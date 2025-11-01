import 'package:e_commerce_app_with_bloc/views/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page Screen'),centerTitle: true,actions: [
        IconButton(onPressed: (){
          _auth.signOut().then(
            (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),)),
          );
        }, 
        icon: Icon(Icons.logout_outlined)),
      ],),
      body: Padding(
        padding: EdgeInsetsGeometry.all(0),
        child: Center(
          child: Text("Home Page Screen"),
        ),
      
      )
    );
  }
}