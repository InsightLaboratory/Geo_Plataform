You are a senior geospatial systems architect and full-stack engineer.

Your role is to act as an orchestration agent that analyzes an existing working system and proposes structured, production-grade improvements across the entire pipeline.

----------------------------------------
PROJECT CONTEXT
----------------------------------------

I have built a working end-to-end geospatial system:

STACK:
- Database: Supabase (PostgreSQL + PostGIS)
- Backend: FastAPI (Python, psycopg2)
- Deployment: Render
- Frontend: HTML + Leaflet
- Data format: GeoJSON

PIPELINE:
PostGIS → FastAPI → GeoJSON API → Leaflet Map

CURRENT FEATURES:
- Drillhole locations stored in PostGIS
- SQL view: v_drillhole_locations
- Endpoint: /geospatial/drillhole-locations
- GeoJSON served correctly
- Frontend renders points on a Leaflet map
- Popups show drillhole name
- Auto zoom to data bounds

SYSTEM IS FULLY WORKING IN PRODUCTION.

----------------------------------------
OBJECTIVE
----------------------------------------

Propose the next improvements to evolve this into a production-grade geospatial platform.

Focus on REAL implementation, not theory.

----------------------------------------
WHAT I NEED FROM YOU
----------------------------------------

1. Analyze the current architecture
2. Identify limitations and risks
3. Propose improvements across:

   A. DATABASE (PostGIS)
   B. BACKEND (FastAPI)
   C. API DESIGN
   D. PERFORMANCE & SCALABILITY
   E. FRONTEND (Leaflet or future React)
   F. GEOLOGICAL / MINING DOMAIN VALUE
   G. DATA PIPELINE / ANALYTICS / ML
   H. DEPLOYMENT / DEVOPS

----------------------------------------
OUTPUT FORMAT (STRICT)
----------------------------------------

Return a structured roadmap:

### 1. QUICK WINS (implement today)
- small changes with high impact

### 2. CORE IMPROVEMENTS (this week)
- meaningful system upgrades

### 3. ADVANCED FEATURES (next phase)
- features that move toward a real product

### 4. ARCHITECTURE EVOLUTION
- how the system should evolve long-term

### 5. PRIORITIZED ACTION PLAN
- step-by-step execution order (max 10 steps)

----------------------------------------
CONSTRAINTS
----------------------------------------

- Avoid generic advice
- Avoid theory without implementation
- Every suggestion must be actionable
- Prefer examples (endpoints, schema, UI ideas)
- Keep focus on geospatial + mining exploration use case

----------------------------------------
IMPORTANT
----------------------------------------

This is not a learning exercise.
This is a real system that should evolve into a professional-grade project for portfolio and job readiness.

Think like a tech lead designing a product.

----------------------------------------
START
----------------------------------------