# Campus AR Navigation & Accessibility Assistant — Final Project Report

Author: shi-va988
Date: 2026-10-18

Executive Summary
-----------------
Campus AR Navigation & Accessibility Assistant is a mobile-first system that provides accurate indoor and outdoor navigation across a campus, combining AR overlays, indoor localization (BLE fingerprinting + IMU fusion), and accessibility-aware routing. The solution includes a Flutter mobile client (AR + BLE), a Node.js backend for routing and map management, and an admin React portal for uploading floor plans and managing beacons.

Objectives
----------
- Deliver an AR-guided navigation experience for campus users.
- Support accessibility-first routing (avoid stairs, prefer elevators/ramps, audio-first guidance).
- Provide backend tools for administrators to manage maps, beacons, and POIs.
- Evaluate localization accuracy, navigation success, and usability.

System Overview
---------------
- Mobile (Flutter): AR view (ar_flutter_plugin), BLE scanner (flutter_reactive_ble), IMU sensors (sensors_plus), TTS (flutter_tts), and haptics (vibration).
- Backend (Node.js/Express + Postgres): stores campus graphs (nodes/edges), beacons, computes accessibility-aware routes using A*.
- Admin (React + Vite): allows uploading floor plans, placing nodes/edges, and mapping beacons to locations.
- Data: Postgres DB schema under docs/db_schema.sql.

Core Features
-------------
- AR Wayfinding: overlays path markers and directional arrows anchored to detected planes.
- Indoor Positioning: BLE fingerprinting with calibration offline dataset and IMU-based dead-reckoning fusion.
- Accessibility Profiles: user preferences (avoid stairs, prefer elevators) influence A* edge costs.
- Audio & Haptic Guidance: TTS for voice instructions and vibration patterns for turns/distance cues.
- Admin Tools: visual floor editor and beacon management API.

Implementation Details
----------------------
1. Indoor Graph Model
- Nodes: junctions, PoIs, doors, elevator/stair entries. Coordinates are local to floor plans (meters).
- Edges: connect nodes with attributes (distance, stair, elevator, ramp, width, accessible flag).
- Stored in Postgres; routing query uses indices on nodes and edges.

2. Routing Algorithm
- A* search with heuristic = Euclidean distance.
- Edge cost = distance + accessibility penalties. Example: if avoid_stairs = true and edge.stair = true then add large penalty.
- Supports cross-floor routing via elevator/stair edges (must include edges connecting floors).

3. Indoor Localization
- Calibration step: collect RSSI vectors at labeled nodes to build a fingerprinting dataset.
- Runtime: scan beacons, form RSSI vector, perform KNN/ML lookup to infer nearest node, fuse with IMU step detection & heading for smoothing.
- AR SLAM correction: when AR pose is available, use relative transform to refine local position.

4. AR UX Patterns
- Arrow pointing to next waypoint and a path of small markers on the ground plane.
- HUD shows distance to next turn and estimated arrival time.
- Accessibility mode: audio-first (announce next instruction and vibrate), large-contrast visuals.

Evaluation Plan
---------------
- Localization accuracy: sample at N points; metric = median error (meters).
- Navigation success: % users reaching destination within ±20% of optimal time.
- Accessibility check: verify routes for avoid_stairs contain no stairs.
- Usability: SUS score and qualitative interviews with 5–10 participants including visually impaired users.

Deployment & Operations
-----------------------
- Backend deployed via Docker Compose (docker-compose.yml) for quick local testing.
- Production recommendations: Kubernetes, TLS (Let's Encrypt), Postgres managed instance.
- Monitoring: collect beacon health, route success events, and CPU/battery telemetry (optional, opt-in).

Ethics & Privacy
----------------
- Obtain consent for collecting any movement traces. Provide opt-out.
- Store minimal personally-identifying data. Use anonymized IDs for analytics.
- Secure the backend with HTTPS and authenticated admin endpoints.

What’s Included in the Repo
--------------------------
- backend/: Node.js + Express starter with routing implementation.
- admin/: React starter for map & beacon management.
- mobile/: Flutter starter app scaffold with BLE and AR placeholders.
- docs/: DB schema, project report drafts, slides, and helper scripts.
- .github/workflows/: GitHub Actions workflows for building full-dev ZIP and APK.

How to Build the Report and Slides Locally
-----------------------------------------
This repo includes markdown sources for the report and slides. To generate PDF and PPTX locally, install Pandoc and a PDF engine (wkhtmltopdf or LaTeX). Use the build script at docs/build_docs.sh.

Notes & Next Steps
------------------
- Finish BLE fingerprint dataset collection and seed DB with sample nodes/edges.
- Integrate AR plugin rendering with actual route nodes (convert 2D floor coordinates to AR world coordinates during plane detection).
- Run field trials and collect evaluation metrics.

