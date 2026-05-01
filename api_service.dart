import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class ApiService {
  static const String baseUrl = 'https://api.genzpro.pk';
  static const int timeoutSeconds = 30; // Increased from 15 to 30
  static const int maxRetries = 2; // Retry 2 times if timeout

  // Create headers
  static Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'User-Agent': 'TechApp/1.0',
    };
  }

  // Retry logic
  static Future<http.Response> _makeRequest(
    Future<http.Response> Function() request, {
    int retries = 0,
  }) async {
    try {
      return await request().timeout(
        Duration(seconds: timeoutSeconds),
        onTimeout: () => throw TimeoutException('Request timeout'),
      );
    } on TimeoutException {
      if (retries < maxRetries) {
        print('⏱️ Timeout, retrying... (attempt ${retries + 1}/$maxRetries)');
        await Future.delayed(Duration(seconds: 2)); // Wait 2 seconds before retry
        return _makeRequest(request, retries: retries + 1);
      } else {
        print('❌ Max retries reached');
        rethrow;
      }
    }
  }

  // Login Method
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      print('🔐 Login attempt: $email');
      print('📡 URL: $baseUrl/login.php');

      final response = await _makeRequest(
        () => http.post(
          Uri.parse('$baseUrl/login.php'),
          headers: _getHeaders(),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
        ),
      );

      print('📊 Status: ${response.statusCode}');
      print('📄 Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}'
        };
      }
    } on SocketException catch (e) {
      print('❌ Socket error: $e');
      return {
        'success': false,
        'message': 'No internet connection'
      };
    } on TimeoutException catch (e) {
      print('❌ Timeout: $e');
      return {
        'success': false,
        'message': 'Server is slow. Try again.'
      };
    } catch (e) {
      print('❌ Error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Signup Method
  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
    required String dob,
    required String gender,
    String? phone,
    String? address,
    String? course,
  }) async {
    try {
      print('📝 Signup attempt: $email');

      final response = await _makeRequest(
        () => http.post(
          Uri.parse('$baseUrl/signup.php'),
          headers: _getHeaders(),
          body: jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'dob': dob,
            'gender': gender,
            'phone': phone ?? '',
            'address': address ?? '',
            'course': course ?? '',
          }),
        ),
      );

      print('📊 Status: ${response.statusCode}');
      return jsonDecode(response.body);
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Signup took too long. Try again.'
      };
    } catch (e) {
      print('❌ Signup error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Get Profile Method
  static Future<Map<String, dynamic>> getProfile(int userId) async {
    try {
      print('👤 Getting profile: $userId');

      final response = await _makeRequest(
        () => http.post(
          Uri.parse('$baseUrl/get_profile.php'),
          headers: _getHeaders(),
          body: jsonEncode({'user_id': userId}),
        ),
      );

      print('📊 Status: ${response.statusCode}');
      return jsonDecode(response.body);
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Profile load took too long. Try again.'
      };
    } catch (e) {
      print('❌ Get profile error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // Update Profile Method
  static Future<Map<String, dynamic>> updateProfile({
    required int userId,
    String? name,
    String? phone,
    String? address,
    String? course,
    String? dob,
  }) async {
    try {
      print('✏️ Updating profile: $userId');

      final response = await _makeRequest(
        () => http.post(
          Uri.parse('$baseUrl/update_profile.php'),
          headers: _getHeaders(),
          body: jsonEncode({
            'user_id': userId,
            if (name != null) 'name': name,
            if (phone != null) 'phone': phone,
            if (address != null) 'address': address,
            if (course != null) 'course': course,
            if (dob != null) 'dob': dob,
          }),
        ),
      );

      print('📊 Status: ${response.statusCode}');
      return jsonDecode(response.body);
    } on TimeoutException {
      return {
        'success': false,
        'message': 'Update took too long. Try again.'
      };
    } catch (e) {
      print('❌ Update error: $e');
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}