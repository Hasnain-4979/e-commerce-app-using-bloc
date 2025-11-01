import 'package:e_commerce_app_with_bloc/views/auth/home/home_page_screen.dart';
import 'package:e_commerce_app_with_bloc/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  final String verificationId;
  const VerifyScreen({super.key, required this.verificationId});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final phoneNUmberController = TextEditingController();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Number')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),
            TextFormField(
              controller: phoneNUmberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hint: Text('6 digit code')),
            ),
            SizedBox(height: 80),
            RoundButton(title: 'Verify', isLoading: isLoading, onTap: () async{
              setState(() {
                isLoading = true;
              });
              final credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId, 
                smsCode: phoneNUmberController.text.toString(),
                );
                try {
                  await auth.signInWithCredential(credential);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageScreen()));
                } catch (e) {
                 setState(() {
                   isLoading = false;
                 }); 
                }
            }),
          ],
        ),
      ),
    );
  }
}
