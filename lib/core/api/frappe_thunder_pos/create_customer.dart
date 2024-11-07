import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateCustomer {
  final String cookie;
  final String customerName;
  final String customerType;
  final String customerGroup;
  final String territory;
  final String? id;

  CreateCustomer({
    required this.cookie,
    required this.customerType,
    required this.customerName,
    required this.customerGroup,
    required this.territory,
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
      "customer_name": customerName,
      "customer_type": customerName,
      "customer_group": customerGroup,
      "territory": territory,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

Future<Map<String, dynamic>> request(
    {required CreateCustomer requestQuery}) async {
  String url;

  if (requestQuery.getParamID() != null) {
    url =
        'https://erp2.hotelkontena.com/api/resource/Customer/${requestQuery.getParamID()}';
  } else {
    url = 'https://erp2.hotelkontena.com/api/resource/Customer';
  }

  final response = await http.post(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

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
