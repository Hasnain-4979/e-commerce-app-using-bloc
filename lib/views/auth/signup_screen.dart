import 'package:e_commerce_app_with_bloc/views/auth/login_screen.dart';
import 'package:e_commerce_app_with_bloc/widgets/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup Successful! Please Login')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    hint: Text('Full Name'),
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Full Name';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hint: Text('Email'),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hint: Text('Password'),
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    }
                    if (value.length < 8) {
                      return 'Password Must be 8 Chahacter Long';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hint: Text('Confirm Password'),
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm Password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    
                    return null;
                  }
                ),

                SizedBox(height: 30),

                RoundButton(
                  title: 'Signup',
                  onTap: _signup,
                  isLoading: isLoading,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('If Already hava an account'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
