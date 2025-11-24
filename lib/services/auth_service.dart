import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  // Register new customer
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String userType,
    String? address,
  }) async {
    try {
      final requestData = {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'userType': userType,
        if (address != null && address.isNotEmpty) 'address': address,
      };

      print(
        '📤 SENDING REGISTRATION DATA: name=$name, email=$email, phone=$phone, userType=$userType, hasPassword=${password.isNotEmpty}, passwordLength=${password.length}',
      );

      final response = await _apiService.post(
        '/auth/register',
        data: requestData,
      );

      print('📥 REGISTRATION RESPONSE: ${response.statusCode}');
      print('📥 RESPONSE DATA: ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data;
        print('✅ REGISTRATION SUCCESS: ${data}');

        // Backend returns data nested in 'data' object
        final responseData = data['data'] ?? data;
        final token = responseData['token'];
        final user = responseData['user'];

        print(
          '💾 SAVING USER DATA: userId=${user['id']}, userType=${user['userType']}',
        );

        // Save user data and token
        await _saveAuthData(
          token: token,
          userId: user['id'],
          userType: user['userType'],
          userName: user['name'],
          userEmail: user['email'],
        );

        return {
          'success': true,
          'message': data['message'] ?? 'Registration successful',
          'user': user,
          'token': token,
        };
      } else {
        return {'success': false, 'message': 'Registration failed'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Login with email and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('📤 SENDING LOGIN DATA: email=$email');

      final response = await _apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      print('📥 LOGIN RESPONSE: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = response.data;
        print('✅ LOGIN SUCCESS: $data');

        // Backend returns data nested in 'data' object
        final responseData = data['data'] ?? data;
        final token = responseData['token'];
        final user = responseData['user'];

        // Save user data and token
        await _saveAuthData(
          token: token,
          userId: user['id'],
          userType: user['userType'],
          userName: user['name'],
          userEmail: user['email'],
        );

        return {
          'success': true,
          'message': 'Login successful',
          'user': user,
          'token': token,
        };
      } else {
        return {'success': false, 'message': 'Login failed'};
      }
    } catch (e) {
      print('❌ LOGIN ERROR: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Verify OTP
  Future<Map<String, dynamic>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/verify-otp',
        data: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'success': true,
          'message': data['message'] ?? 'OTP verified successfully',
        };
      } else {
        return {'success': false, 'message': 'OTP verification failed'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Resend OTP
  Future<Map<String, dynamic>> resendOTP({required String email}) async {
    try {
      final response = await _apiService.post(
        '/auth/resend-otp',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'success': true,
          'message': data['message'] ?? 'OTP sent successfully',
        };
      } else {
        return {'success': false, 'message': 'Failed to send OTP'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Login with OTP (request OTP)
  Future<Map<String, dynamic>> loginWithOTP({required String phone}) async {
    try {
      final response = await _apiService.post(
        '/auth/login-with-otp',
        data: {'phone': phone},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'success': true,
          'message': data['message'] ?? 'OTP sent to your phone',
        };
      } else {
        return {'success': false, 'message': 'Failed to send OTP'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Verify Login OTP
  Future<Map<String, dynamic>> verifyLoginOTP({
    required String phone,
    required String otp,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/verify-login-otp',
        data: {'phone': phone, 'otp': otp},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Save user data and token
        await _saveAuthData(
          token: data['token'],
          userId: data['user']['_id'],
          userType: data['user']['userType'],
          userName: data['user']['name'],
          userEmail: data['user']['email'],
        );

        return {
          'success': true,
          'message': 'Login successful',
          'user': data['user'],
          'token': data['token'],
        };
      } else {
        return {'success': false, 'message': 'OTP verification failed'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Forgot Password (send reset OTP)
  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    try {
      final response = await _apiService.post(
        '/auth/forgot-password',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'success': true,
          'message': data['message'] ?? 'Password reset OTP sent to your email',
        };
      } else {
        return {'success': false, 'message': 'Failed to send reset OTP'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Reset Password
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/reset-password',
        data: {'email': email, 'otp': otp, 'newPassword': newPassword},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        return {
          'success': true,
          'message': data['message'] ?? 'Password reset successful',
        };
      } else {
        return {'success': false, 'message': 'Password reset failed'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Get current user profile
  Future<Map<String, dynamic>> getUserProfile() async {
    try {
      final response = await _apiService.get('/auth/me');

      if (response.statusCode == 200) {
        final data = response.data;
        return {'success': true, 'user': data['user']};
      } else {
        return {'success': false, 'message': 'Failed to fetch user profile'};
      }
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _apiService.clearToken();
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    return token != null && token.isNotEmpty;
  }

  // Get saved token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Get saved user data
  Future<Map<String, String?>> getSavedUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getString('user_id'),
      'userName': prefs.getString('user_name'),
      'userEmail': prefs.getString('user_email'),
      'userType': prefs.getString('user_type'),
      'token': prefs.getString('auth_token'),
    };
  }

  // Private helper to save auth data
  Future<void> _saveAuthData({
    required String token,
    required String userId,
    required String userType,
    required String userName,
    required String userEmail,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('user_id', userId);
    await prefs.setString('user_type', userType);
    await prefs.setString('user_name', userName);
    await prefs.setString('user_email', userEmail);

    _apiService.setToken(token);
  }
}
