# Campus AR Navigation — Presentation Slides

% Campus AR Navigation & Accessibility Assistant

---

# Slide 1

Campus AR Navigation & Accessibility Assistant

Team: shi-va988
Date: 2026-10-18

---

# Slide 2

Problem Statement

- Indoor navigation is hard in complex campuses.
- Mobility-impaired and visually-impaired users need accessible routes.
- Current maps often lack indoor detail and accessible-routing.

---

# Slide 3

Goals

- AR-guided wayfinding across indoor/outdoor areas.
- Accessibility-first routing (avoid stairs, prefer elevators).
- Admin tools for map & beacon management.

---

# Slide 4

System Architecture

- Mobile (Flutter): AR, BLE, sensor fusion
- Backend (Node.js + Postgres): routing & map storage
- Admin (React): floor editor & beacon manager

---

# Slide 5

Indoor Localization

- BLE fingerprinting for coarse localization
- IMU-based step & heading smoothing
- AR SLAM used to refine pose when available

---

# Slide 6

Routing Algorithm

- A* search on indoor graph
- Accessibility penalties for stairs; elevator/ramp preference
- Heuristic: Euclidean distance in floor coordinates

---

# Slide 7

AR UX & Accessibility

- Floating arrows & path markers
- Audio-first instructions and haptic patterns
- High-contrast visuals and large typography

---

# Slide 8

Demo Screens

- Home (destination input)
- 2D Floor map editor (Admin)
- AR navigation view with waypoints

---

# Slide 9

Evaluation Plan

- Localization accuracy (median error)
- Navigation success rate
- Usability (SUS)
- Accessibility compliance checks

---

# Slide 10

Roadmap & Future Work

- Integrate indoor SLAM improvements
- Campus-wide rollout and scalability
- Offline-first capabilities

---

# Slide 11

Thank you

Questions?

