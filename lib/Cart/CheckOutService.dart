import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckOutService {
  static Future<void> getCheckOut() async {
    var headers = {
      'Authorization':
          'Bearer 1643548163\$2y\$10\$0.s7NDaUuUDwgWjpBl7VpOpwWgwAfrjZfhdrTaC3Isf7Dfo/MPdXO1643548163',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IlBMTGttWm9RY1h1WWVJeVwvK0diTm1RPT0iLCJ2YWx1ZSI6IkRrclNlTTB3SU9cL2t0cVJid0NvajB3QU84YUJIWVI3NnRpTHJFYnlSUTVDd3VCWjBDdDNSVlI0T1B2QktnbHRTIiwibWFjIjoiYmE4M2U4Yjk0MmVjMDQxMzM3YTZkNWZkMmUwMjM2Nzc1ZWJkNWNkMGE5NjViNDNhZDQ0YWJiZjg4YTc1NTdkOCJ9; laravel_session=eyJpdiI6IjhMWFJxeDZUNTNSMmR0MmhaVTJ4K3c9PSIsInZhbHVlIjoiTzN1Z2xGM1ptemt1ellcL3pLd1B3QnJ4SFJvK1VkdUF1a2ROMWNOZ0lkZGRPUlRnVm50d0x6TWlhaEhsM0dSY1giLCJtYWMiOiIzNWEzYzk1NjMyNjNhMDgwMmQwMTUxZDVjNjM2ZDkzZTEzYTUwNWIwYTJhOTE4OWYyOTU3NWE1NzA4NjQyYzgxIn0%3D'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://www.moharaj.com.bd/api/_public/checkout?mobile_no=12345678928&name=tekashi68&address=Wari&city=1&sub_city=320&shipping_cost=120&p_m=cash'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
