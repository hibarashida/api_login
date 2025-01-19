import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class MainProvider with ChangeNotifier {

  /// bottomNavigation

  int selectedIndex = 0;


  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
  int selectedFilterIndex = 0;
  int get _selectedFilterIndex => selectedFilterIndex;

  // Function to update the selected filter index
  void updateSelectedIndex(int index) {
    selectedFilterIndex = index;
    notifyListeners(); // Notify listeners after updating the index
  }

  final List<String> filters = ['Pending', "Invoiced", "Cancelled"];


  final List<Map<String, dynamic>> dashboardData = [
    {
      'icon': Icons.book,
      'title': 'Bookings',
      'value': '123',
      'subtitle': 'Reserved',
    },
    {
      'icon': Icons.money,
      'title': 'Earnings',
      'value': '10,232.00',
      'subtitle': 'Rupees',
    },
    {
      'icon': Icons.history,
      'title': 'History',
      'value': '236',
      'subtitle': 'Trips',
    },
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Accounts',
      'value': 'Rs. 23,485.00',
      'subtitle': 'Default account',
    },
  ];




  bool _isFirstImage = true;

  bool get isFirstImage => _isFirstImage;

  void toggleImage() {
    _isFirstImage = !_isFirstImage;
    notifyListeners(); // Notify widgets to rebuild
  }


  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _userDetails;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get userDetails => _userDetails;

  String userName='';
  String userEmail='';
  String userPhoto='';


  // Fetch user details
  Future<void> fetchUserDetails(String userID) async {
    print("Working");
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('https://www.api.viknbooks.com/api/v10/users/user-view/$userID/');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        print("Token not found in SharedPreferences");
        _isLoading = false;
        notifyListeners();
        return; // Exit early
      }

      print("Token: $token");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data != null) {
          print("Response body: ${response.body}");
          _userDetails = data;
          userName = data["data"]["username"] ?? '';
          userEmail =data["data"]["email"] ?? '';
          userPhoto =data["data"]["photo"] ?? '';
        } else {
          print("Response body is null or not a valid JSON");
        }
      } else {
        print("Failed to fetch user details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }






  



}