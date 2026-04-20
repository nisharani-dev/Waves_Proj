-- Run this in your Supabase SQL Editor to set up the database

-- Users table (for email/password auth)
CREATE TABLE IF NOT EXISTS users (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Pipeline status table
CREATE TABLE IF NOT EXISTS pipeline_status (
  id SERIAL PRIMARY KEY,
  room_name TEXT UNIQUE NOT NULL,
  status TEXT NOT NULL DEFAULT 'No leakage detected',
  leakage_detected BOOLEAN DEFAULT FALSE,
  time_duration TEXT,
  distance_range TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Seed default rooms (matches the Flutter app)
INSERT INTO pipeline_status (room_name, status, leakage_detected)
VALUES
  ('MAIN PIPELINE', 'No leakage detected', FALSE),
  ('ROOM 1',        'No leakage detected', FALSE),
  ('ROOM 2',        'No leakage detected', FALSE),
  ('ROOM 3',        'No leakage detected', FALSE),
  ('ROOM 4',        'No leakage detected', FALSE),
  ('KITCHEN',       'No leakage detected', FALSE),
  ('LIVING ROOM',   'No leakage detected', FALSE)
ON CONFLICT (room_name) DO NOTHING;
