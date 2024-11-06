import 'dart:convert';
import 'package:http/http.dart' as http;

class CancelPosOrderRequest {
  final String cookie;
  final String cartNo;
  final int docstatus;
  final String id;

  CancelPosOrderRequest({
    required this.cookie,
    required this.docstatus,
    required this.cartNo,
    required this.id,
  });

  Map<String, String> formatHeader() {
    return {
      'Cookie': cookie,
      // 'Content-Type': 'application/x-www-form-urlencoded',
    };
  }

  String? getParamID() {
    return id;
  }

  Map<String, dynamic> toJson() {
    final data = {
      // "doctype": "POS Order",
      // "name": id,
      "docstatus": 2,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }

  String toJsonString() {
    // Convert the map to JSON string
    return json.encode(toJson());
  }
}

Future<Map<String, dynamic>> request(
    {required CancelPosOrderRequest requestQuery}) async {
  // final getResponse = await http.get(
  //   Uri.parse(
  //       'https://erp2.hotelkontena.com/api/resource/POS Order/${requestQuery.getParamID()}'),
  //   headers: requestQuery.formatHeader(),
  // );

  // final getData = json.decode(getResponse.body);

  // Pastikan 'modified' dari dokumen terbaru
  // final latestModified = getData['data'];
  String url =
      'https://erp2.hotelkontena.com/api/resource/POS Order/${requestQuery.getParamID()}';

  final response = await http.put(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

  // print('body, ${requestQuery.toJson()}');
  // print('body, ${json.encode(latestModified)}');

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