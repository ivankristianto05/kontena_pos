import 'dart:convert';
import 'package:http/http.dart' as http;

class CreatePosInvoiceRequest {
  final String cookie;
  final String company;
  final String customer;
  final String customerName;
  final String outlet;
  final String postingDate;
  final String postingTime;
  final String currency;
  final int conversionRate;
  final String sellingPriceList;
  final String priceListCurrency;
  final int plcConversionRate;
  final String debitTo;
  final String costCenter;
  final String? cartNo;
  List<dynamic> items = [];
  final double baseNetTotal;
  final double baseGrandTotal;
  final double grandTotal;
  List<dynamic> payments = [];
  final double basePaidAmount;
  final double paidAmount;

  CreatePosInvoiceRequest({
    required this.cookie,
    required this.customer,
    required this.customerName,
    required this.company,
    required this.outlet,
    required this.postingDate,
    required this.postingTime,
    required this.currency,
    required this.conversionRate,
    required this.sellingPriceList,
    required this.priceListCurrency,
    required this.plcConversionRate,
    required this.debitTo,
    required this.costCenter,
    this.cartNo,
    required this.items,
    required this.baseNetTotal,
    required this.baseGrandTotal,
    required this.grandTotal,
    required this.payments,
    required this.basePaidAmount,
    required this.paidAmount,
  });

  Map<String, String> formatHeader() {
    return {'Cookie': cookie};
  }

  Map<String, dynamic> toJson() {
    final data = {
      "docstatus": 1,
      "company": company,
      "pos_profile": outlet,
      "posting_date": postingDate,
      "posting_time": postingTime,
      "currency": currency,
      "naming_series": "ACC-PSINV-.YYYY.-",
      "conversion_rate": conversionRate,
      "selling_price_list": sellingPriceList,
      "price_list_currency": priceListCurrency,
      "plc_conversion_rate": plcConversionRate,
      "debit_to": debitTo,
      "cost_center": costCenter,
      "is_pos": 1,
      "customer": customer,
      "pos_cart": cartNo,
      "items": items,
      "base_net_total": baseNetTotal,
      "base_grand_total": baseGrandTotal,
      "grand_total": grandTotal,
      "payments": payments,
      "base_paid_amount": basePaidAmount,
      "paid_amount": paidAmount,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

Future<Map<String, dynamic>> request(
    {required CreatePosInvoiceRequest requestQuery}) async {
  String url = 'https://erp2.hotelkontena.com/api/resource/POS Invoice';
  // print('check data, ${json.encode(requestQuery.toJson())}');
  final response = await http.post(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    print('check, $responseBody');
    if (responseBody.containsKey('data')) {
      return responseBody['data'];
    } else {
      throw Exception(responseBody);
    }
  } else {
    final responseBody = json.decode(response.body);

    throw Exception(responseBody);
  }
}
