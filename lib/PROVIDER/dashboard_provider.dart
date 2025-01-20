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
    final url = Uri.parse('https://www.api.viknbooks.com/api/v10/sales/sale-list-page/');
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
        if (data["data"] != null) {
          _salesList = (data["data"] as List)
              .map((item) => SalesData.fromJson(item))
              .toList();
          print("Sales List Updated: ${_salesList.length}");
        } else {
          print("No data found in API response.");
        }
      } else {
        print("Error: Failed to fetch sales list. Status Code: ${response.statusCode}");
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
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime scheduledDate = DateTime.now();
  String scheduledDayNode = "";
  var outputDateFormat = DateFormat('dd/MM/yyyy');
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
      _startDate=picked;


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
      _endDate=picked;
      notifyListeners();
    }
  }


  void setStartDate(DateTime date) {
    _startDate = date;

    notifyListeners();
  }


  void setEndDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }


// Get filtered sales data
  List<SalesData> _filteredSalesList() {
    List<SalesData> filteredList = _salesList;

    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((sale) {
        final customerName = sale.customerName.toLowerCase();
        final voucherNo = sale.voucherNo.toLowerCase();
        return customerName.contains(_searchQuery.toLowerCase()) ||
            voucherNo.contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (startdateController.text != null && enddateController.text != null) {
      filteredList = filteredList.where((sale) {
        return sale.date.isAfter(_startDate!) && sale.date.isBefore(_endDate!);
      }).toList();
    }

    return filteredList;
  }







}



