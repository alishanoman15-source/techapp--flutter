import 'package:hive_flutter/hive_flutter.dart';

class StorageService {
  static const String _userBoxName = 'userBox';

  // Initialize Hive
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox(_userBoxName);
  }

  // Get user box
  static Box _getUserBox() {
    return Hive.box(_userBoxName);
  }

  // Save user ID (as int)
  static Future<void> saveUserId(int userId) async {
    final box = _getUserBox();
    await box.put('user_id', userId);
  }
  // Get user ID (returns int)
static Future<int?> getUserId() async {
  final box = _getUserBox();
  final id = box.get('user_id');
  if (id == null) return null;
  if (id is int) return id;
  if (id is String) {
    try {
      return int.parse(id);
    } catch (e) {
      return null;
    }
  }
  return null;
}


  // Save user email
  static Future<void> saveUserEmail(String email) async {
    final box = _getUserBox();
    await box.put('user_email', email);
  }

  // Get user email
  static Future<String?> getUserEmail() async {
    final box = _getUserBox();
    return box.get('user_email');
  }

  // Save user name
  static Future<void> saveUserName(String name) async {
    final box = _getUserBox();
    await box.put('user_name', name);
  }

  // Get user name
  static Future<String?> getUserName() async {
    final box = _getUserBox();
    return box.get('user_name');
  }

  // Save all user data
  static Future<void> saveUserData({
    required int userId,
    required String email,
    required String name,
  }) async {
    final box = _getUserBox();
    await box.putAll({
      'user_id': userId,
      'user_email': email,
      'user_name': name,
    });
  }

  // Clear all data (logout)
  static Future<void> clearAllData() async {
    final box = _getUserBox();
    await box.clear();
  }

  // Check if logged in
  static Future<bool> isUserLoggedIn() async {
    final userId = await getUserId();
    return userId != null;
  }
}