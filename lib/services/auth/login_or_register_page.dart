import 'package:flutter/material.dart';
import 'package:mini_chat_app/pages/login_page.dart';
import 'package:mini_chat_app/pages/registeration_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showlogin=true;
  void togglepage(){
    setState(() {
      showlogin=!showlogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showlogin) {
      return LoginPage(ontap: togglepage,);
    }else{
      return RegisterPage(ontap: togglepage,);
    }
  }
}