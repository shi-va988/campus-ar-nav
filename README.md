# Campus AR Navigation & Accessibility Assistant

This repository contains a starter scaffold for the Campus AR Navigation project.

Included:
- backend/ : Node.js + Express backend with a simple routing endpoint
- admin/ : Vite + React minimal admin UI
- docs/ : database schema and supporting docs
- docker-compose.yml : starter compose file for DB + backend + admin

I intentionally omitted node_modules. To run locally:

Backend
-------
cd backend
npm install
# create DB and run schema (use psql)
# psql -U postgres -d campus_nav -f ../docs/db_schema.sql
cp .env.example .env
npm start

Admin
-----
cd admin
npm install
npm run dev

If you want, I can also scaffold the mobile Flutter app and add sample data (nodes/edges) to the DB. Next I can:
- Add migrations and a seed script that inserts sample floor graph and beacons
- Scaffold the Flutter mobile app (BLE + AR placeholders)
- Create GitHub Actions CI

