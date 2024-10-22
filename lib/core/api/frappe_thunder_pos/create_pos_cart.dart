import 'dart:convert';
import 'package:http/http.dart' as http;

class CreatePosCartRequest {
  final String cookie;
  final String company;
  final String customer;
  final String customerName;
  final String table;
  final String outlet;
  final String postingDate;
  final String priceList;
  final String? id;

  CreatePosCartRequest({
    required this.cookie,
    required this.customer,
    required this.customerName,
    required this.company,
    required this.postingDate,
    required this.outlet,
    required this.table,
    required this.priceList,
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
      "docstatus": 1,
      "customer": customer,
      "customer_name": customerName,
      "company": company,
      "pos_profile": outlet,
      "date": postingDate,
      "table": table,
      "selling_price_list": priceList,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

Future<Map<String, dynamic>> request(
    {required CreatePosCartRequest requestQuery}) async {
  String url;

  if (requestQuery.getParamID() != null) {
    url =
        'https://erp2.hotelkontena.com/api/resource/POS Cart/${requestQuery.getParamID()}';
  } else {
    url = 'https://erp2.hotelkontena.com/api/resource/POS Cart';
  }

  print('json, ${json.encode(requestQuery.toJson())}');

  final response = await http.post(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

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
