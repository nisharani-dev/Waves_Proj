import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://waves-proj.onrender.com';

  // ─── Auth ────────────────────────────────────────────────────────────────

  /// Login with email + password. Saves JWT token on success.
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Save token locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        return {'success': true, 'token': data['token']};
      } else {
        return {'success': false, 'error': data['error'] ?? 'Login failed.'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error. Check your connection.'};
    }
  }

  /// Register a new user.
  static Future<Map<String, dynamic>> register(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        return {'success': true};
      } else {
        return {'success': false, 'error': data['error'] ?? 'Registration failed.'};
      }
    } catch (e) {
      return {'success': false, 'error': 'Network error. Check your connection.'};
    }
  }

  /// Logout — clears saved token.
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  /// Check if user is logged in.
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  // ─── Pipeline ────────────────────────────────────────────────────────────

  /// Fetch all room pipeline statuses from the backend.
  static Future<List<Map<String, dynamic>>> getPipelineStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pipeline/status'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List rooms = data['rooms'];
        return rooms.cast<Map<String, dynamic>>();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
