import 'dart:convert';
import 'package:http/http.dart' as http;

class CreatePosOrderRequest {
  final String cookie;
  final String company;
  final String customer;
  final String customerName;
  final String outlet;
  final String postingDate;
  final String priceList;
  final String cartNo;
  final String item;
  final String itemName;
  final String itemGroup;
  final String? note;
  final int qty;

  CreatePosOrderRequest({
    required this.cookie,
    required this.customer,
    required this.customerName,
    required this.company,
    required this.postingDate,
    required this.outlet,
    required this.priceList,
    required this.cartNo,
    required this.item,
    required this.itemName,
    required this.itemGroup,
    this.note,
    required this.qty,
  });

  Map<String, String> formatHeader() {
    return {'Cookie': cookie};
  }

  Map<String, dynamic> toJson() {
    final data = {
      "customer": customer,
      "customer_name": customerName,
      "company": company,
      "pos_profile": outlet,
      "date": postingDate,
      "pos_cart": cartNo,
      "item": item,
      "item_name": itemName,
      "item_group": itemGroup,
      "note": note,
      "qty": qty,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

Future<Map<String, dynamic>> requestCalculateVoucher(
    {required CreatePosOrderRequest requestQuery}) async {
  String url = 'https://erp2.hotelkontena.com/api/resource/POS Order';

  final response = await http.post(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    if (responseBody.containsKey('message')) {
      return responseBody;
    } else {
      throw Exception(responseBody);
    }
  } else {
    final responseBody = json.decode(response.body);

    throw Exception(responseBody);
  }
}
