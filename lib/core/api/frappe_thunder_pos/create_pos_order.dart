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
  final String uom;
  final String? note;
  final int qty;
  final int status;
  final String? id;

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
    required this.uom,
    this.note,
    required this.qty,
    required this.status,
    this.id,
  });

  Map<String, String> formatHeader() {
    return {'Cookie': cookie};
  }

  String? getParamID() {
    return id;
  }

  Map<String, dynamic> toJson() {
    final data = {
      "docstatus": status,
      "customer": customer,
      "customer_name": customerName,
      "company": company,
      "pos_profile": outlet,
      "date": postingDate,
      "pos_cart": cartNo,
      "item": item,
      "item_name": itemName,
      "item_group": itemGroup,
      "uom": uom,
      "note": note,
      "quantity": qty,
      "ots_dlv": status == 1 ? 1 : 0,
      "ots_bill": 0,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

Future<Map<String, dynamic>> request(
    {required CreatePosOrderRequest requestQuery}) async {
  String url;

  if (requestQuery.getParamID() != null) {
    url =
        'https://erp2.hotelkontena.com/api/resource/POS Order/${requestQuery.getParamID()}';
  } else {
    url = 'https://erp2.hotelkontena.com/api/resource/POS Order';
  }

  print('url, $url');
  print('body, ${json.encode(requestQuery.toJson())}');

  final response = await http.post(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

  print('response code, ${response.statusCode}');
  print('respon body, ${response.body}');

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    if (requestQuery.getParamID() != null) {
      if (responseBody.containsKey('data')) {
        return responseBody['data'];
      } else {
        return requestQuery.toJson();
      }
    } else {
      if (responseBody.containsKey('data')) {
        return responseBody['data'];
      } else {
        throw Exception(responseBody);
      }
    }
  } else {
    final responseBody = json.decode(response.body);

    throw Exception(responseBody);
  }
}
