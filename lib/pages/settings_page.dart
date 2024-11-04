import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_chat_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Mode"),
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isdarkmode, onChanged: (value){
              setState(() {
                Provider.of<ThemeProvider>(context,listen: false).toggletheme();
              }); 
            })
          ],
        ),
      ),
    );
  }
}