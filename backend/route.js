const { Pool } = require('pg');
const TinyQueue = require('tinyqueue');
const DB = require('./db');

function heuristic(a, b) {
  const dx = a.x - b.x;
  const dy = a.y - b.y;
  return Math.sqrt(dx*dx + dy*dy);
}

async function loadNodes(floor_id) {
  const res = await DB.query('SELECT id, x, y FROM nodes WHERE floor_id = $1', [floor_id]);
  return res.rows;
}

async function loadEdges(floor_id) {
  const res = await DB.query('SELECT * FROM edges WHERE node_a IN (SELECT id FROM nodes WHERE floor_id=$1) OR node_b IN (SELECT id FROM nodes WHERE floor_id=$1)', [floor_id]);
  return res.rows;
}

function reconstructPath(cameFrom, currentId) {
  const path = [currentId];
  while (cameFrom.has(currentId)) {
    currentId = cameFrom.get(currentId);
    path.unshift(currentId);
  }
  return path;
}

async function findPath(from, to, profile) {
  if (!from || !to || !from.floor_id || !from.node_id || !to.floor_id || !to.node_id) {
    throw new Error('from and to must contain floor_id and node_id');
  }
  if (from.floor_id !== to.floor_id) {
    throw new Error('Cross-floor routing not implemented in starter (use elevator/stairs edges)');
  }
  const floor = from.floor_id;
  const nodes = await loadNodes(floor);
  const edges = await loadEdges(floor);
  const nodeMap = new Map(nodes.map(n => [n.id, n]));

  const start = nodeMap.get(from.node_id);
  const goal = nodeMap.get(to.node_id);
  if (!start || !goal) throw new Error('start or goal node not found');

  const open = new TinyQueue([], (a,b) => a.f - b.f);
  const gScore = new Map();
  const cameFrom = new Map();

  gScore.set(start.id, 0);
  open.push({ node: start, f: heuristic(start, goal) });

  const edgeIndex = new Map();
  for (const e of edges) {
    edgeIndex.set(e.id, e);
  }

  const neighborsOf = (nid) => {
    return edges.filter(e => e.node_a === nid || e.node_b === nid).map(e => {
      const other = e.node_a === nid ? e.node_b : e.node_a;
      return { edge: e, neighborId: other };
    });
  };

  while (open.length) {
    const current = open.pop().node;
    if (current.id === goal.id) {
      const path = reconstructPath(cameFrom, goal.id);
      return { nodes: path };
    }
    for (const nb of neighborsOf(current.id)) {
      const e = nb.edge;
      const neighbor = nodeMap.get(nb.neighborId);
      if (!neighbor) continue;
      let tentativeG = gScore.get(current.id) + e.distance;
      if (profile && profile.avoid_stairs && e.stair) tentativeG += 10000;
      if (profile && profile.prefer_elevator && e.elevator) tentativeG -= 1;
      const prevG = gScore.get(neighbor.id);
      if (prevG === undefined || tentativeG < prevG) {
        cameFrom.set(neighbor.id, current.id);
        gScore.set(neighbor.id, tentativeG);
        const f = tentativeG + heuristic(neighbor, goal);
        open.push({ node: neighbor, f });
      }
    }
  }
  throw new Error('No route found');
}

module.exports = { findPath };
