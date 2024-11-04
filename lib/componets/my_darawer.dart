import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_chat_app/services/auth/auth_login_services.dart';
import 'package:mini_chat_app/pages/settings_page.dart';
import 'package:mini_chat_app/services/auth/auth_logout_service.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void logout() {
    final authlogoutservice = AuthLogoutServices();
    authlogoutservice.logout();
  }

  @override
  void initState() {
    getusername();
    super.initState();
  }

  final AuthLoginServices authlogin = AuthLoginServices();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? username;
  getusername() async {
    String currentuserid = authlogin.getcurrentuser()!.uid;
    final Map<String, dynamic> userdata = await _firestore
        .collection('Users')
        .doc(currentuserid)
        .get()
        .then((DocumentSnapshot snapshot) {
      return snapshot.data() as Map<String, dynamic>;
    });

    setState(() {
      username = userdata['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ListTile(leading: const Icon(Icons.person),title: Text(username ?? "" ,style: const TextStyle( letterSpacing: 1.5,),)),
                  ),
                ],
              )),
              //home list title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              //setting list title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  },
                ),
              ),
              //
              //logout
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              title: const Text("L O G O U T"),
              leading: const Icon(Icons.exit_to_app),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
