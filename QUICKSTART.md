# 🚀 GeoPlatform v3.0 - Quick Start Guide

## Backend API Status

✅ **Production API:** `https://geo-plataform.onrender.com`

- 9 REST endpoints
- FastAPI + PostgreSQL (Supabase)
- New endpoint: `/drillholes/{id}/summary`

## Frontend Setup (React v3.0)

### 1️⃣ Install Dependencies

```bash
cd web
npm install
```

### 2️⃣ Start Development Server

```bash
npm run dev
```

Opens at: **http://localhost:3000**

### 3️⃣ Build for Production

```bash
npm run build
# Output in: web/dist/
```

## 🎨 Features Implemented

- ⚛️ **React 18** + TypeScript
- 🎨 **Shadcn/ui** components (Card, Button, etc)
- 🗺️ **React-Leaflet** with OpenStreetMap
- 🌙 **Dark Mode** (toggle in header)
- 📊 **Summary Statistics** using new `/summary` endpoint
- 📡 **Type-safe API** integration with Axios
- 📱 **Responsive Design** (mobile-friendly)

## 📐 Project Structure

```
geo_platform/
├── api/                # FastAPI backend
│   └── main.py        # Python API server
├── web/               # React frontend (NEW!)
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── pages/         # Page layouts
│   │   ├── context/       # Dark mode state
│   │   ├── lib/           # API client
│   │   └── types/         # TypeScript interfaces
│   ├── package.json
│   ├── vite.config.ts
│   ├── tailwind.config.js
│   └── index.html
├── database/          # PostgreSQL schema
└── seeds/             # Data loading scripts
```

## 🌙 Dark Mode

- Automatic system preference detection
- Toggle button in header
- Preference saved to localStorage
- Tailwind CSS dark mode support

## 📊 Summary Card

The new `DrillholeSummaryCard` component shows:

- **Total Samples:** Count of all samples in drillhole
- **Avg Au:** Average gold value (ppm/ppb)
- **Max Au:** Maximum gold value observed

Data from new endpoint: `/drillholes/{id}/summary`

## 🔧 Configuration

Edit `web/.env`:

```env
# Production (default)
VITE_API_URL=https://geo-plataform.onrender.com

# Local development
VITE_API_URL=http://localhost:8000
```

## 📡 API Integration

Type-safe API calls via `src/lib/api.ts`:

```typescript
import { api } from '@/lib/api'

// Fetch drillhole locations
const data = await api.getDrillholeLocations()

// Get summary stats
const summary = await api.getDrillholeSummary(drillholeId)

// Get assays
const assays = await api.getAssays(drillholeId, 'Au')
```

## 🎯 Next Steps

1. **Deploy Frontend:**
   ```bash
   npm run build
   # Upload dist/ to Vercel, Netlify, or Render
   ```

2. **Add Analytics:**
   - Recharts is ready to use
   - Create depth profile charts
   - Element distribution graphs

3. **Enhance Features:**
   - 3D drillhole viewer (Three.js)
   - Cross-section generator
   - Lithology/alteration drill-down
   - Export to PDF

## 🚀 Deployment Options

### Vercel (Recommended)
```bash
npm run build
# Push to GitHub, connect to Vercel
```

### Netlify
```bash
npm run build
# Drag & drop dist/ folder
```

### Self-hosted
```bash
npm run build
# Serve dist/ with nginx/Apache
```

---

**Status:** ✅ Ready for Production

**Last Updated:** March 2026 | **Version:** 3.0.0
