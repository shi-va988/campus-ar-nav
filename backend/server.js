const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const dotenv = require('dotenv');
const { findPath } = require('./route');
const { initDb } = require('./db');

dotenv.config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

// health
app.get('/api/health', (req, res) => res.json({ status: 'ok' }));

app.post('/api/v1/route', async (req, res) => {
  const { from, to, profile } = req.body;
  try {
    const route = await findPath(from, to, profile);
    res.json({ route, estimated_time: route.estimated_time || 300 });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: e.message || 'routing error' });
  }
});

const PORT = process.env.PORT || 3000;

initDb().then(() => {
  app.listen(PORT, () => console.log(`Backend listening on ${PORT}`));
}).catch(err => {
  console.error('Failed to initialize DB', err);
  process.exit(1);
});
