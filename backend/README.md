# Campus AR Navigation - Backend

This is the starter Node.js + Express backend for the Campus AR Navigation project.

Quick start (Linux/macOS/Windows with WSL):

1. Install dependencies
   cd backend
   npm install

2. Create database and run schema (use psql or a GUI)
   psql -U postgres -d campus_nav -f ../docs/db_schema.sql

3. Copy env
   cp .env.example .env
   Edit .env if needed

4. Start server
   npm start

The /api/v1/route endpoint expects JSON with from/to nodes and returns a node sequence.
