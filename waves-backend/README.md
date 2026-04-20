# Waves Backend

Backend API for the **Waves** water pipeline leak detection app.  
Built with **Node.js + Express**, **Supabase** (PostgreSQL), deployed on **Render**.

---

## API Endpoints

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| POST | `/auth/register` | Register a new user | None |
| POST | `/auth/login` | Login, returns JWT | None |
| GET | `/pipeline/status` | Get all room statuses | None |
| PUT | `/pipeline/status/:room` | Update a room's status | None (open) |
| GET | `/admin` | Admin panel UI | None (open) |
| GET | `/health` | Health check | None |

---

## Local Setup

### 1. Clone the repo
```bash
git clone https://github.com/nisharani-dev/Waves_Proj.git
cd waves-backend
```

### 2. Install dependencies
```bash
npm install
```

### 3. Set up Supabase
1. Go to [supabase.com](https://supabase.com) and create a free project
2. Open the **SQL Editor** and run the contents of `supabase/schema.sql`
3. Go to **Project Settings → API** and copy:
   - `Project URL`
   - `service_role` key (under API keys)

### 4. Configure environment variables
```bash
cp .env.example .env
```
Fill in your `.env`:
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
JWT_SECRET=any_long_random_string
PORT=3000
```

### 5. Run the server
```bash
# Development (auto-restart)
npm run dev

# Production
npm start
```

Server runs at `http://localhost:3000`  
Admin panel at `http://localhost:3000/admin`

---

## Deploy to Render (Free)

1. Push this repo to GitHub
2. Go to [render.com](https://render.com) → **New Web Service**
3. Connect your GitHub repo
4. Set:
   - **Root Directory:** `waves-backend`
   - **Build Command:** `npm install`
   - **Start Command:** `npm start`
5. Add environment variables (same as `.env`) under **Environment**
6. Deploy — Render gives you a public URL like `https://waves-backend.onrender.com`

---

## Example API Usage

### Register
```bash
curl -X POST https://your-url/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"yourpassword"}'
```

### Login
```bash
curl -X POST https://your-url/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"yourpassword"}'
```

### Get pipeline status
```bash
curl https://your-url/pipeline/status
```

### Update a room (admin)
```bash
curl -X PUT https://your-url/pipeline/status/ROOM%202 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "Minor leakage detected",
    "leakage_detected": true,
    "time_duration": "2 hours",
    "distance_range": "3-5 meters"
  }'
```

---

## Project Structure

```
waves-backend/
├── src/
│   ├── app.js                  # Express app entry point
│   ├── db/
│   │   └── supabase.js         # Supabase client
│   ├── middleware/
│   │   └── auth.js             # JWT verification middleware
│   └── routes/
│       ├── auth.js             # Register / Login
│       └── pipeline.js         # Pipeline status CRUD
├── admin/
│   └── index.html              # Admin panel UI
├── supabase/
│   └── schema.sql              # Database setup SQL
├── .env.example
├── package.json
└── README.md
```
