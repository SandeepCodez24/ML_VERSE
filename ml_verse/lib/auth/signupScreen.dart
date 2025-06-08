import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ml_verse/api/auth_api.dart';
import 'package:ml_verse/auth/authTextFormWidget.dart';
import 'package:ml_verse/widgets/GlowButton.dart';
import 'package:lottie/lottie.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  final PageController _pageController = PageController();
  bool isSignedUp = true;
  int currentPage = 0;
  bool _isloading = false;
  Future<void> _submitForm() async {
    if (_formkey.currentState!.validate()) {
      try {
        setState() {
          _isloading = !_isloading;
        }

        if (isSignedUp) {
          _isloading
              ? Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: SizedBox(
                      height: 300,
                      width: 350,
                      child: Lottie.asset(
                        'assets/Animation - 1734255686454.json',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              )
              : print('animation falied');
          await ApiService.signUp(
            _emailcontroller.text,
            _password.text,
            _confirmPassword.text,
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Signup successful!')));
        } else {
          ScaffoldMessenger(
            child: SnackBar(content: Text('Please fill all fields')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Signup failed!')));
      } finally {
        setState() => _isloading = false;
      }
    }
  }

  @override
  void initState() {
    _userName;
    _emailcontroller;
    _password;
    _confirmPassword;
    _formkey;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _userName;
    _emailcontroller;
    _password;
    _confirmPassword;
    _formkey;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff060912),
      body: Container(
        height: screenHeight,
        margin: const EdgeInsets.symmetric(vertical: 65),
        color: Colors.transparent,
        width: screenWidth,
        child: Form(
          key: _formkey,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text(
                      'Sign up an account',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: screenWidth * 0.02,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  /// Row of textfields ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authTextFormCustom(
                        boxText: 'Username',
                        hintText: 'Enter your username',
                        labelText: 'Username',
                        controller: _userName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          } else if (value.length < 6) {
                            return 'Username must be at least 6 characters long';
                          }
                          return null;
                        },
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.08,
                      ),
                      SizedBox(width: 25),
                      authTextFormCustom(
                        boxText: 'Mail Id',
                        hintText: 'Enter your mail id',
                        labelText: 'Mail Id',
                        controller: _emailcontroller,
                        validator: (value) => EmailValidator.validate(value),
                        width: screenWidth * 0.2,
                        height: screenHeight * 0.08,
                      ),
                    ],
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GlowButton(
                      height: screenHeight * 0.08,
                      width: screenWidth * 0.42,
                      buttonText: 'Sign up',
                      onPressed: () async {
                        setState(() {
                          _isloading = true;
                        });
                        try {
                          await Future.delayed(Duration(seconds: 3));
                          _submitForm();
                          setState(() {
                            _isloading = false;
                          });
                        } catch (e) {
                          setState(() {
                            _isloading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Signup failed!')),
                          );
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
