const express = require('express');
const router = express.Router();
const supabase = require('../db/supabase');
const verifyToken = require('../middleware/auth');

// GET /pipeline/status — public, Flutter app calls this
router.get('/status', async (req, res) => {
  try {
    const { data, error } = await supabase
      .from('pipeline_status')
      .select('*')
      .order('id', { ascending: true });

    if (error) throw error;

    return res.status(200).json({ rooms: data });
  } catch (err) {
    console.error('Get status error:', err.message);
    return res.status(500).json({ error: 'Internal server error.' });
  }
});

// PUT /pipeline/status/:room — admin update (open for now)
router.put('/status/:room', async (req, res) => {
  const { room } = req.params;
  const { status, leakage_detected, time_duration, distance_range } = req.body;

  if (!status) {
    return res.status(400).json({ error: 'Status is required.' });
  }

  try {
    const { data, error } = await supabase
      .from('pipeline_status')
      .update({
        status,
        leakage_detected: leakage_detected ?? false,
        time_duration: time_duration ?? null,
        distance_range: distance_range ?? null,
        updated_at: new Date().toISOString(),
      })
      .eq('room_name', room.toUpperCase())
      .select()
      .single();

    if (error) throw error;
    if (!data) {
      return res.status(404).json({ error: `Room "${room}" not found.` });
    }

    return res.status(200).json({ message: 'Status updated.', room: data });
  } catch (err) {
    console.error('Update status error:', err.message);
    return res.status(500).json({ error: 'Internal server error.' });
  }
});

// POST /pipeline/status — admin: add a new room (open for now)
router.post('/status', async (req, res) => {
  const { room_name, status, leakage_detected, time_duration, distance_range } = req.body;

  if (!room_name || !status) {
    return res.status(400).json({ error: 'room_name and status are required.' });
  }

  try {
    const { data, error } = await supabase
      .from('pipeline_status')
      .insert([{
        room_name: room_name.toUpperCase(),
        status,
        leakage_detected: leakage_detected ?? false,
        time_duration: time_duration ?? null,
        distance_range: distance_range ?? null,
      }])
      .select()
      .single();

    if (error) throw error;

    return res.status(201).json({ message: 'Room added.', room: data });
  } catch (err) {
    console.error('Add room error:', err.message);
    return res.status(500).json({ error: 'Internal server error.' });
  }
});

module.exports = router;
