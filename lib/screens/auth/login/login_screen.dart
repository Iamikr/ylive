


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:skincare/screens/auth/login/component/body.dart';
import 'package:skincare/screens/dashboard/dashboard_screen.dart';






class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isChecked = true; // Initial state
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    // if (user!=null){
    //   return Dashboard();
    // }
    return SignInBody();
  }
}
