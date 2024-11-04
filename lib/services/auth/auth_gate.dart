import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_chat_app/services/auth/login_or_register_page.dart';
import 'package:mini_chat_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: 
      FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot){
        if (snapshot.hasData) {
          return  const HomePage();
        }else{
          return const LoginOrRegisterPage();
        }
      }),
    );
  }
}