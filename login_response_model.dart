import 'user_model.dart';

class LoginResponse {
  final bool success;
  final String message;
  final User? user;

  LoginResponse({
    required this.success,
    required this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }
}