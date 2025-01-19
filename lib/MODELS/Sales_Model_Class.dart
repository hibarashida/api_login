class SalesData {
  final int index;
  final String id;
  final String voucherNo;
  final DateTime date;
  final String ledgerName;
  final double totalGrossAmtRounded;
  final double totalTaxRounded;
  final double grandTotalRounded;
  final String customerName;
  final double totalTax;
  final String status;
  final double grandTotal;
  final bool isBillWised;
  final String billwiseStatus;

  SalesData({
    required this.index,
    required this.id,
    required this.voucherNo,
    required this.date,
    required this.ledgerName,
    required this.totalGrossAmtRounded,
    required this.totalTaxRounded,
    required this.grandTotalRounded,
    required this.customerName,
    required this.totalTax,
    required this.status,
    required this.grandTotal,
    required this.isBillWised,
    required this.billwiseStatus,
  });

  factory SalesData.fromJson(Map<String, dynamic> json) {
    return SalesData(
      index: json['index'],
      id: json['id'],
      voucherNo: json['VoucherNo'],
      date: DateTime.parse(json['Date']),
      ledgerName: json['LedgerName'],
      totalGrossAmtRounded: json['TotalGrossAmt_rounded'].toDouble(),
      totalTaxRounded: json['TotalTax_rounded'].toDouble(),
      grandTotalRounded: json['GrandTotal_Rounded'].toDouble(),
      customerName: json['CustomerName'],
      totalTax: json['TotalTax'].toDouble(),
      status: json['Status'],
      grandTotal: json['GrandTotal'].toDouble(),
      isBillWised: json['is_billwised'],
      billwiseStatus: json['billwise_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'id': id,
      'VoucherNo': voucherNo,
      'Date': date,
      'LedgerName': ledgerName,
      'TotalGrossAmt_rounded': totalGrossAmtRounded,
      'TotalTax_rounded': totalTaxRounded,
      'GrandTotal_Rounded': grandTotalRounded,
      'CustomerName': customerName,
      'TotalTax': totalTax,
      'Status': status,
      'GrandTotal': grandTotal,
      'is_billwised': isBillWised,
      'billwise_status': billwiseStatus,
    };
  }
}

class SalesResponse {
  final int statusCode;
  final List<SalesData> data;

  SalesResponse({
    required this.statusCode,
    required this.data,
  });

  factory SalesResponse.fromJson(Map<String, dynamic> json) {
    return SalesResponse(
      statusCode: json['StatusCode'],
      data: (json['data'] as List)
          .map((item) => SalesData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StatusCode': statusCode,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
