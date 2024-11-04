import 'package:flutter/material.dart';
import 'package:mini_chat_app/services/auth/auth_login_services.dart';
import 'package:mini_chat_app/componets/my_button.dart';
import 'package:mini_chat_app/componets/text_filed.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key,required this.ontap});
final TextEditingController _emailcontroler = TextEditingController();
final TextEditingController _passcontroler = TextEditingController();
final void Function()? ontap;
void login(BuildContext context)async{
final authservice= AuthLoginServices();
try {
  await authservice.signinusingemailandpasword(_emailcontroler.text, _passcontroler.text);
} on Exception catch (e) {
  showDialog(context: context, builder: (context) => AlertDialog(
     content: Text(e.toString()),
  ),);
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
              "Welcome back, you 've been missied!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 10,
            ),
            //emailfield
             MyTextField(hinttext: "Email",obsecure: false,textEditingController:_emailcontroler,),
            const SizedBox(
              height: 10,
            ),
            //pwfield
             MyTextField(hinttext: "Password",obsecure: true,textEditingController: _passcontroler,),
            const SizedBox(
              height: 25,
            ),
            //loginbutton
             MyButton(text: "login",ontap:()=>login(context)),
            //registernow
            const SizedBox(height: 15,),
             GestureDetector(
              onTap: ontap,
               child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                 Text("Not a memeber?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary
                ),),
                Text("Register now",style: 
                TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary  
                ),)
                           ],
                          ),
             )
          ],
        ),
      ),
    );
  }
}
