import 'package:contacts/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    final user = context.read<UserManager>().auth;

    Future.delayed(const Duration(seconds: 4), () {
      if (user.currentUser != null) {
        Navigator.pushNamed(context, '/contacts_screen');
      } else {
        Navigator.pushNamed(context, '/login_screen');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          "assets/logo.gif",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
