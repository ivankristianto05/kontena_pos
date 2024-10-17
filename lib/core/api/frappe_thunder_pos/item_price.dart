import 'dart:convert';
import 'package:http/http.dart' as http;

class salesItemPriceRequest {
  final String cookie;
  final String? fields;
  final String? filters;
  final int? limit;
  final String? orfilters;

  salesItemPriceRequest(
      {required this.cookie,
      this.fields,
      this.limit,
      this.filters,
      this.orfilters});

  Map<String, dynamic> formatRequestSalesItemPrice() {
    Map<String, dynamic> requestMap = {};

    if (fields != null && fields!.isNotEmpty) {
      requestMap['fields'] = fields;
    }

    if (filters != null && filters!.isNotEmpty) {
      requestMap['filters'] = filters;
    }

    if (orfilters != null && orfilters!.isNotEmpty) {
      requestMap['or_filters'] = orfilters;
    }

    if (limit != null) {
      requestMap['limit'] = limit;
    }

    return requestMap;
  }

  Map<String, String> formatHeaderSalesItemPrice() {
    return {
      'Cookie': cookie,
    };
  }
}

String queryParams(Map<String, dynamic> map) =>
    map.entries.map((e) => '${e.key}=${e.value}').join('&');

Future<List<dynamic>> requestItemPrice(
    {required salesItemPriceRequest requestQuery}) async {
  String url =
      'https://erp2.hotelkontena.com/api/resource/Item Price?${queryParams(requestQuery.formatRequestSalesItemPrice())}';

  final response = await http.get(Uri.parse(url),
      headers: requestQuery.formatHeaderSalesItemPrice());

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody.containsKey('data')) {
      return responseBody['data'];
    } else {
      throw Exception(responseBody);
    }
  } else {
    throw Exception('System unknown error code ${response.statusCode}');
  }
}
