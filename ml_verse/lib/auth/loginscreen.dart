import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:ml_verse/api/auth_api.dart';
import 'package:ml_verse/auth/authTextFormWidget.dart';
import 'package:ml_verse/function/appFunction.dart';
import 'package:ml_verse/widgets/GlowButton.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  void initState() {
    _usernameController;
    _emailcontroller;
    _password;
    _confirmPassword;
    _formkey;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailcontroller;
    _password;
    _confirmPassword;
    _formkey;
  }

  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Form(
          key: _formkey,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.02,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Login to your account',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: screenWidth * 0.01,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 5),

                  authTextFormCustom(
                    boxText: 'Mail Id',
                    hintText: 'Enter your mail id',
                    labelText: 'Mail Id',
                    controller: _emailcontroller,
                    validator: (value) => EmailValidator.validate(value),
                    width: screenWidth * 0.42,
                    height: screenHeight * 0.08,
                  ),
                  SizedBox(height: 4),
                  authTextFormCustom(
                    boxText: 'userName',
                    hintText: 'Enter your user name',
                    labelText: 'Username',
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      if (value.length < 3) {
                        return 'Username must be at least 3 characters';
                      }
                      return null;
                    },
                    width: screenWidth * 0.42,
                    height: screenHeight * 0.08,
                  ),
                  SizedBox(height: 4),
                  authTextFormCustom(
                    boxText: 'Password',
                    hintText: 'Enter your password',
                    labelText: 'Password',
                    isPassword: true,
                    controller: _password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    width: screenWidth * 0.42,
                    height: screenHeight * 0.08,
                  ),
                  SizedBox(height: 5),
                  authTextFormCustom(
                    boxText: 'Confirm Password',
                    hintText: 'Enter your password',
                    labelText: 'Confirm Password',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password again';
                      } else if (value != _password.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: _confirmPassword,
                    width: screenWidth * 0.42,
                    height: screenHeight * 0.08,
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GlowButton(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.42,
                      buttonText: 'Login',
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            _isloading = true;
                          });
                          try {
                            await ApiService.logIN(
                              context,
                              _usernameController.text,
                              _emailcontroller.text,
                              _password.text,
                            );
                            await AppFunction.saveLoginStatus(
                              true,
                              _usernameController.text,
                              _emailcontroller.text,
                            );
                          } catch (e) {
                            setState(() {
                              _isloading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                content: Text(
                                  'Login failed: $e',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              _isloading
                  ? Center(
                    child: SizedBox(
                      height: screenWidth * 0.4,
                      width: screenWidth * 0.4,
                      child: Lottie.asset('assets/loading_animation.json'),
                    ),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    ).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
