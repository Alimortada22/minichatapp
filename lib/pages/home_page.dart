import 'package:flutter/material.dart';
import 'package:mini_chat_app/componets/my_darawer.dart';
import 'package:mini_chat_app/pages/chat_page.dart';
import 'package:mini_chat_app/pages/usert_itle.dart';
import 'package:mini_chat_app/services/auth/auth_login_services.dart';
import 'package:mini_chat_app/services/chat_services/chat_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthLoginServices _authServices = AuthLoginServices();

  final SendMessageService _chatServices = SendMessageService();

   String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer:  const MyDrawer(),
      body: _builduserlist(),
    );
  }

  Widget _builduserlist() {
    return StreamBuilder(
        stream: _chatServices.getcurrentusers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const  Center(child:  CircularProgressIndicator());
          }
          return ListView(
              children: snapshot.data!.map((userdata) {
            return _builduserlistitem(userdata, context);
          }).toList());
        });
  }

  Widget _builduserlistitem(
      Map<String, dynamic> userdata, BuildContext context) {
    if (userdata['email'] != _authServices.getcurrentuser()!.email) {
      return UserTitle(
        text: userdata['username']??"",
        ontap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        title: userdata['username'],
                        recieverID: userdata['uid'],
                      )));
        },
      );
    } else {

      return Container();
    }
  }
}
