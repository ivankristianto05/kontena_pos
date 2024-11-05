import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateClosingEntry {
  final String cookie;
  final String periodStart;
  final String periodEnd;
  final String postingDate;
  final String posOpeningId;
  final String company;
  final String posProfile;
  final String user;

  CreateClosingEntry({
    required this.cookie,
    required this.periodStart,
    required this.periodEnd,
    required this.postingDate,
    required this.posOpeningId,
    required this.company,
    required this.posProfile,
    required this.user,
  });

  Map<String, String> formatHeader() {
    return {
      'Cookie': cookie,
    };
  }

  Map<String, dynamic> toJson() {
    final data = {
      // "docstatus": 1,
      "period_start_date": periodStart,
      "period_end_date": periodEnd,
      "posting_date": postingDate,
      "pos_opening_entry": posOpeningId,
      "company": company,
      "pos_profile": posProfile,
      "user": user,
    };

    data.removeWhere((key, value) => value == null);
    return data;
  }
}

Future<Map<String, dynamic>> request(
    {required CreateClosingEntry requestQuery}) async {
  String url = 'https://erp2.hotelkontena.com/api/resource/POS Closing Entry';

  final response = await http.post(
    Uri.parse(url),
    headers: requestQuery.formatHeader(),
    body: json.encode(requestQuery.toJson()),
  );

  print('check ${json.decode(response.body)}');
  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);

    if (responseBody.containsKey('data')) {
      return responseBody['data'];
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
