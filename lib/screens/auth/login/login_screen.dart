


import 'package:flutter/material.dart';

import 'package:skincare/screens/auth/login/component/body.dart';






class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = true; // Initial state
  @override
  Widget build(BuildContext context) {
    return SignInBody();
  }
}
