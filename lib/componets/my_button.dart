import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key,required this.text,required this.ontap});
final String text;
final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child:  Center(
          child: Text(text),
        ),
      ),
    );
  }
}