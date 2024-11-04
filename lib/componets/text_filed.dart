import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key, required this.hinttext, required this.obsecure,required this.textEditingController,this.focusNode});
  final String hinttext;
  final bool obsecure;
  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: TextField(
        obscureText: obsecure,
        focusNode: focusNode,
        controller: textEditingController,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            hintText: hinttext),
      ),
    );
  }
}
