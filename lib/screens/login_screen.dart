import 'package:flutter/material.dart';
import 'package:jobs_app/screens/jobs_screen.dart';
import 'package:jobs_app/services/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    try {
      final res = await _authService.loginUser(email, password);

      if (res['userId'] != null) {
        String userId = res['userId'];

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => JobsScreen(userid: userId),
          ),
        );
      } else {
        String message;
        if (email == "" && password == "") {
          message = "Please enter your email address and password.";
        } else if (email == "") {
          message = "Please enter your email address.";
        } else if (password == "") {
          message = "Please enter your password.";
        } else {
          message = "Invalid email or password.";
        }
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red[300],
            textColor: Colors.white,
            fontSize: 13.0);
      }
    } catch (e) {
      print('Login failed: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: const Image(
                    image: AssetImage('assets/jobs.png'), width: 200),
              ),
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 45.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Login to your account",
                        style: TextStyle(fontSize: 22))),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          labelText: 'Enter Email',
                          suffixIcon: Icon(Icons.mail_outline)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Enter Password',
                          suffixIcon: Icon(Icons.lock_open)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 120),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "LOGIN",
                            style: TextStyle(color: Colors.white),
                          )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue)),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}