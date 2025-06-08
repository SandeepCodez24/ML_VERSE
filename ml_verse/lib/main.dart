import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ml_verse/DesktopHomePage.dart';
import 'package:ml_verse/auth/authScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? userName;
  String? email;
  bool? isLoggedIn;

  Future<Map<String, dynamic>> loadUserData() async {
    final pref = await SharedPreferences.getInstance();
    userName = pref.getString('username');
    email = pref.getString('email');
    isLoggedIn = pref.getBool('isLoggedIn') ?? false;
    return {'userName': userName, 'email': email, 'isLoggedIn': isLoggedIn};
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ML Verse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF8A56E5),
      ),
      home: FutureBuilder<Map<String, dynamic>>(
        future: loadUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Lottie.asset('assets/loading_animation.json'),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data['isLoggedIn'] == true &&
                data['userName'] != null &&
                data['email'] != null) {
              return DesktopHomePage(
                userName: data['userName'],
                email: data['email'],
              );
            } else {
              return DesktopHomePage(userName: userName, email: email);
            }
          } else {
            return DesktopHomePage(userName: userName, email: email);
          }
        },
      ),
    );
  }
}
