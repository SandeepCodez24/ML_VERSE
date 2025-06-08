import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:ml_verse/DesktopHomePage.dart";
import "dart:convert";

import "package:ml_verse/function/AppFunction.dart";

class ApiService {
  static const String baseurl = "http://127.0.0.1:5000";

  //sigin up
  static Future<void> signUp(
    BuildContext context,
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
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => DesktopHomePage(userName: userName, email: email),
        ),
      );
      return;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  static Future<void> logIN(
    BuildContext context,
    String username,
    String email,
    String password,
  ) async {
    debugPrint('Login called with email: $email');
    debugPrint('Login called with password: $password');

    try {
      final response = await http.post(
        Uri.parse("$baseurl/signin"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          await AppFunction.saveLoginStatus(true, username, email);
          await Future.delayed(const Duration(seconds: 3));
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      DesktopHomePage(userName: username, email: email),
            ),
          );
        }
        return;
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint('Error during login: $e');
      throw Exception('Login failed: $e');
    }
  }
}
