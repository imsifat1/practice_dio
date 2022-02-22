import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOutService {
  static Future<void> getCheckOut() async {
    var headers = {
      'Authorization':
          'Bearer 1643548163\$2y\$10\$0.s7NDaUuUDwgWjpBl7VpOpwWgwAfrjZfhdrTaC3Isf7Dfo/MPdXO1643548163',
    };

    final response = await http.post(Uri.parse(
        "https://www.moharaj.com.bd/api/_public/checkout?mobile_no=12345678928&name=tekashi68&address=Wari&city=1&sub_city=320&shipping_cost=120&p_m=cash"));

    response.headers.addAll(headers);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
