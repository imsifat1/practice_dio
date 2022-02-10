import 'package:http/http.dart' as http;

class CartToContentService {
  var cartListStatus = "";
  Future<void> getCartContent() async {
    var response = await http
        .get(Uri.parse("https://www.moharaj.com.bd/_public/cartToContent"));

    if (response.statusCode == 200) {
      print(response.body);
      cartListStatus = response.body;
    } else {
      print(response.reasonPhrase);
    }
  }
}
