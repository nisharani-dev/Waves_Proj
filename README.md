# 🌊 Waves — Water Pipeline Leak Detection System

A full-stack IoT-ready application for real-time water pipeline leak detection across rooms in a building. Built with **Flutter** (frontend) and **Node.js + Express + Supabase** (backend), deployed on **Render**.

---

## 🔗 Live Links

| Resource | URL |
|----------|-----|
| 🚀 Backend API | https://waves-proj.onrender.com |
| 🛠 Admin Panel | https://waves-proj.onrender.com/admin |
| ❤️ Health Check | https://waves-proj.onrender.com/health |
| 📊 Pipeline Status API | https://waves-proj.onrender.com/pipeline/status |
| 📦 GitHub Repository | https://github.com/nisharani-dev/Waves_Proj |

---

## 📱 App Overview

Waves monitors water pipelines across different areas of a building and reports leakage status in real time. Users slide to unlock, log in, and see a live dashboard of all pipeline statuses fetched from the backend.

### App Flow

```
LockScreen → LoginScreen → OTP/Email Auth → WavesScreen (splash)
    → PipelineCheckScreen (animated scan) → AnalyticsScreen (live data)
        → RoomDetailsScreen (leakage details)
```

---

## 🏗 Project Structure

```
Waves_Proj/
├── lib/                          # Flutter app source
│   ├── main.dart                 # Entry point — LockScreen (slide to unlock)
│   ├── login.dart                # Phone number login screen
│   ├── otp.dart                  # OTP verification screen
│   ├── email_login.dart          # Email + password login (connected to backend)
│   ├── waves_screen.dart         # Splash screen after login
│   ├── pipeline_check_screen.dart# Animated pipeline scanning screen
│   ├── analytics_screen.dart     # Live dashboard — fetches from backend
│   ├── room_detail_screen.dart   # Room detail with time/distance data
│   └── services/
│       └── api_service.dart      # Centralized API service (auth + pipeline)
│
├── waves-backend/                # Node.js backend
│   ├── src/
│   │   ├── app.js                # Express server entry point
│   │   ├── routes/
│   │   │   ├── auth.js           # POST /auth/login, /auth/register
│   │   │   └── pipeline.js       # GET/PUT /pipeline/status
│   │   ├── middleware/
│   │   │   └── auth.js           # JWT verification middleware
│   │   └── db/
│   │       └── supabase.js       # Supabase client
│   ├── admin/
│   │   └── index.html            # Admin panel UI
│   ├── supabase/
│   │   └── schema.sql            # Database schema + seed data
│   └── .env.example              # Environment variable template
│
├── assets/                       # Images and fonts
│   ├── front_bg.png
│   ├── main_bg.png
│   └── fonts/                    # Inria Serif font family
│
└── web/                          # Flutter web build config
```

---

## ⚙️ Tech Stack

| Layer | Technology |
|-------|-----------|
| Mobile/Web Frontend | Flutter 3.32 (Dart) |
| Backend | Node.js + Express |
| Database | Supabase (PostgreSQL) |
| Authentication | JWT (jsonwebtoken + bcryptjs) |
| Deployment | Render (free tier) |
| Font | Inria Serif |

---

## 🔌 API Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| GET | `/health` | Health check | None |
| POST | `/auth/register` | Register new user | None |
| POST | `/auth/login` | Login, returns JWT | None |
| GET | `/pipeline/status` | Get all room statuses | None |
| PUT | `/pipeline/status/:room` | Update a room's status | None (open) |
| GET | `/admin` | Admin panel UI | None (open) |

### Example: Get Pipeline Status
```bash
curl https://waves-proj.onrender.com/pipeline/status
```

### Example: Update Room Status (Admin)
```bash
curl -X PUT https://waves-proj.onrender.com/pipeline/status/ROOM%202 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "Minor leakage detected",
    "leakage_detected": true,
    "time_duration": "2 hours",
    "distance_range": "3-5 meters"
  }'
```

### Example: Login
```bash
curl -X POST https://waves-proj.onrender.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"yourpassword"}'
```

---

## 🗄 Database Schema

```sql
-- Users table
CREATE TABLE users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,       -- bcrypt hashed
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Pipeline status table
CREATE TABLE pipeline_status (
  id SERIAL PRIMARY KEY,
  room_name TEXT UNIQUE NOT NULL,
  status TEXT NOT NULL,
  leakage_detected BOOLEAN DEFAULT FALSE,
  time_duration TEXT,           -- e.g. "2 hours"
  distance_range TEXT,          -- e.g. "3-5 meters"
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
```

**Default rooms seeded:** MAIN PIPELINE, ROOM 1, ROOM 2, ROOM 3, ROOM 4, KITCHEN, LIVING ROOM

---

## 🚀 Local Setup

### Flutter App

```bash
# Clone the repo
git clone https://github.com/nisharani-dev/Waves_Proj.git

# Install dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome --no-web-resources-cdn

# Run on Android (requires emulator or device)
flutter run
```

### Backend

```bash
cd waves-backend

# Install dependencies
npm install

# Copy and fill environment variables
cp .env.example .env

# Run in development
npm run dev

# Run in production
npm start
```

### Environment Variables (`.env`)

```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
JWT_SECRET=your_jwt_secret
PORT=3000
```

---

## ☁️ Deployment

### Backend on Render
1. Connect GitHub repo to [render.com](https://render.com)
2. New Web Service → Root Directory: `waves-backend`
3. Build Command: `npm install`
4. Start Command: `npm start`
5. Add environment variables in Render dashboard

### Database on Supabase
1. Create project at [supabase.com](https://supabase.com)
2. Run `waves-backend/supabase/schema.sql` in the SQL Editor
3. Copy Project URL and service_role key to Render env vars

---

## 🔮 Roadmap

- [ ] Real IoT sensor integration (sensors POST data to `/pipeline/status/:room`)
- [ ] Push notifications on leak detection
- [ ] Admin panel password protection
- [ ] Historical leakage data and charts
- [ ] Android APK release

---

## 📁 Additional Resources

- [APK Download](https://drive.google.com/file/d/1wGt1eODbNTmAdlHFairnd0ZbiZZUCXDP/view?usp=sharing)
- [Project Drive Folder](https://drive.google.com/drive/folders/14Qe-9q81yEbwaZodEBg7ygBbM6_2nT6W?usp=sharing)

---

## 👩‍💻 Author

**Nisha Rani** — [github.com/nisharani-dev](https://github.com/nisharani-dev)
