import "package:http/http.dart" as http;
import "dart:convert";

class ApiService {
  static const String baseurl = "http://127.0.0.1:5000";

  //sigin up
  static Future<void> signUp(
    String email,
    String password,
    String userName,
  ) async {
    final response = await http.post(
      Uri.parse("$baseurl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": userName,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 201) {
      return;
    } else {
     throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<void> logIN(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseurl/signin"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return;
    }
    else {
     throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
