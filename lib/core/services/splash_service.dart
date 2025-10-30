import 'dart:async';
import 'package:e_commerce_app_with_bloc/views/auth/home/home_page_screen.dart';
import 'package:e_commerce_app_with_bloc/views/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
        Duration(seconds: 3),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageScreen()),
        ),
      );
    } else {
      Timer(
        Duration(milliseconds: 100),
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        ),
      );
    }
  }
}
