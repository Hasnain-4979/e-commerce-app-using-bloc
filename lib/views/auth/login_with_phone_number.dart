import 'package:e_commerce_app_with_bloc/views/auth/varify_code.dart';
import 'package:e_commerce_app_with_bloc/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneNUmberController = TextEditingController();
  bool isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: 
      Padding(padding: EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(height: 10),
          TextFormField(
            controller: phoneNUmberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hint: Text('+1 988 789 997')
              ),
          ),
          SizedBox(height: 80),
          RoundButton(
            title: 'Verify',
            isLoading: isLoading,
            onTap: () {
              setState(() {
                isLoading = true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneNUmberController.text,
                verificationCompleted: (_) {
                   setState(() {
                    isLoading = false;
                  });
                },
                verificationFailed: (error) => {
                  setState(() {
                    isLoading = false;
                  }),
                },
                codeSent: (verificationId, forceResendingToken) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VerifyScreen(verificationId: verificationId),
                    ),
                  );
                },
                codeAutoRetrievalTimeout: (verificationId) {
                  setState(() {
                    isLoading = false;
                  });
                },
              );
            },
          ),
        ],
      ),
      ),
    );
  }
}
