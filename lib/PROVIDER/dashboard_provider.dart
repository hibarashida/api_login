import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../MODELS/Sales_Model_Class.dart';

class SalesProvider with ChangeNotifier {
  bool _isLoading = false;
  int _currentPage = 1;

  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  List<SalesData> filtersalesList = [];
  List<SalesData> datewisefiltersalesList = [];
  List<SalesData> _salesList = [];

  /// search

  String _searchQuery = "";
  void setSalesList(List<dynamic> salesData) {
    _salesList = salesData.map((json) => SalesData.fromJson(json)).toList();
    notifyListeners();
  }

  List<SalesData> get filteredSalesList {
    if (_searchQuery.isEmpty) {
      return _salesList;
    }

    return _salesList.where((sale) {
      final customerName = sale.customerName.toLowerCase();
      final voucherNo = sale.voucherNo.toLowerCase();
      return customerName.contains(_searchQuery.toLowerCase()) ||
          voucherNo.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// fetch data

  Future<void> fetchSales(int page, String userId, String tokens) async {
    final url = Uri.parse(
        'https://www.api.viknbooks.com/api/v10/sales/sale-list-page/');
    final payload = {
      "BranchID": 1,
      "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
      "CreatedUserID": userId,
      "PriceRounding": 2,
      "page_no": page,
      "items_per_page": 10,
      "type": "Sales",
      "WarehouseID": 1,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(payload),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokens',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);
        if (data["data"] != null) {
          _salesList = (data["data"] as List)
              .map((item) => SalesData.fromJson(item))
              .toList();
          filtersalesList = _salesList;
          datewisefiltersalesList = _salesList;
          print("Sales List Updated: ${_salesList.length}");
        } else {
          print("No data found in API response.");
        }
      } else {
        print(
            "Error: Failed to fetch sales list. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// filter page calender function

  DateTime _date = DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  DateTime scheduledDate = DateTime.now();
  String scheduledDayNode = "";
  var outputDateFormat = DateFormat('yyyy/MM/dd');
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
      scheduledDate = DateTime(_date.year, _date.month, _date.day);
      startdateController.text = outputDateFormat.format(scheduledDate);
      startDate = picked;

      notifyListeners();
    }
  }

  Future<void> endSelectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _date = picked;
      scheduledDate = DateTime(_date.year, _date.month, _date.day);
      enddateController.text = outputDateFormat.format(scheduledDate);
      endDate = picked;
      notifyListeners();
    }
  }

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
    dateWiseFilteredSalesList();
  }

  void setEndDate(DateTime date) {
    endDate = date;
    notifyListeners();
    dateWiseFilteredSalesList();
  }

// Get filtered sales data

  void dateWiseFilteredSalesList() {
    // if (_searchQuery.isNotEmpty) {
    //   filtersalesList = filtersalesList.where((sale) {
    //     final customerName = sale.customerName.toLowerCase();
    //     final voucherNo = sale.voucherNo.toLowerCase();
    //     return customerName.contains(_searchQuery.toLowerCase()) ||
    //         voucherNo.contains(_searchQuery.toLowerCase());
    //   }).toList();
    // }
    if (startdateController.text != '' && enddateController.text != '') {
      print(".........................");
      datewisefiltersalesList = _salesList.where((sale) {
        return sale.date.isAfter(startDate) && sale.date.isBefore(endDate);
      }).toList();
      notifyListeners();
    }
  }

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String _selectedMonth = "This Month";

  String get selectedMonth => _selectedMonth;

  void updateSelectedMonth(String newMonth) {
    _selectedMonth = newMonth;
    print("/////////////////////////");
    if (newMonth == "This Month") {
      DateTime now = DateTime.now();
      startDate = DateTime(now.year, now.month, 1);

      endDate = DateTime(now.year, now.month + 1, 0);
    } else {
      int monthIndex = months.indexOf(newMonth) + 1; // Months are 1-based
      print(monthIndex.toString());
      DateTime now = DateTime.now();
      startDate = DateTime(now.year, monthIndex, 1);
      startdateController.text = outputDateFormat.format(startDate);
      endDate = DateTime(now.year, monthIndex + 1, 0);
      enddateController.text = outputDateFormat.format(endDate);
      print(startdateController.text);
      print(enddateController.text);
      notifyListeners();
    }
    notifyListeners();
  }

  /// customer dropdown
  List<SalesData> _salesData = [];
  SalesData? _selectedCustomer;

  List<SalesData> get salesData => _salesData;
  SalesData? get selectedCustomer => _selectedCustomer;

  void setSalesData(List<SalesData> data) {
    _salesData = data;
    notifyListeners();
  }

  void selectCustomer(SalesData customer) {
    _selectedCustomer = customer;
    notifyListeners();
  }
}
