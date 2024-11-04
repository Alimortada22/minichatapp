import 'package:flutter/material.dart';
import 'package:mini_chat_app/services/auth/auth_register_service.dart';
import 'package:mini_chat_app/componets/my_button.dart';
import 'package:mini_chat_app/componets/text_filed.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key, required this.ontap});
  final TextEditingController _emailcontroler = TextEditingController();
  final TextEditingController _passcontroler = TextEditingController();
  final TextEditingController _confirpasscontroler = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();

  final void Function()? ontap;
  void signup(BuildContext context) {
    final authregisteredservice = AuthRegisterServices();
    if (_passcontroler.text == _confirpasscontroler.text) {
      try {
        authregisteredservice.signupwithemailandpassword(_emailcontroler.text,
            _passcontroler.text, _usernamecontroller.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("password not identical"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 60,
            ),
            const SizedBox(
              height: 15,
            ),
            //welcome back
            Text(
              "Let's create an account ,for you",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            //username
            MyTextField(
              hinttext: "User Name",
              obsecure: false,
              textEditingController: _usernamecontroller,
            ),
            const SizedBox(
              height: 10,
            ),
            //emailfield
            MyTextField(
              hinttext: "Email",
              obsecure: false,
              textEditingController: _emailcontroler,
            ),
            const SizedBox(
              height: 10,
            ),
            //pwfield
            MyTextField(
              hinttext: "Password",
              obsecure: true,
              textEditingController: _passcontroler,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              hinttext: "Confirm Password",
              obsecure: true,
              textEditingController: _confirpasscontroler,
            ),
            const SizedBox(
              height: 25,
            ),

            //loginbutton
            MyButton(text: "Register", ontap: () => signup(context)),
            //registernow
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: ontap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an accout?",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  Text(
                    "Login now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
