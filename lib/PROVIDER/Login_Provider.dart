import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../CONSTANTS/Call_Functions.dart';
import '../VIEW_SCREENS/Login_Screen.dart';

class LoginProvider with ChangeNotifier {

  /// password visible method

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void toggleVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }


  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  String userId='';

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://api.accounts.vikncodes.com/api/v1/users/login');
    final payload = {
      "username":username,
      "password": password,
      "is_mobile": true,
    };
    try {

      final response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        log(data.toString() + "fetched data");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", data["data"]["access"]);
        await prefs.setString("userID",data["data"]["user_id"].toString());
        notifyListeners();
      } else {
            "Login failed. Please try again.";
        notifyListeners();
      }
    } catch (e) {
      print(e.toString() + "error");
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }





  /// Logout
  Future<void> logout(BuildContext context) async {
    print("here");
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.clear();
      callNextReplacement(context, LoginScreen());
      print("User logged out successfully.");
    } catch (e) {
      print("Logout error: $e");
    }
  }

}
