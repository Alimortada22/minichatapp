import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  final void Function() ontap;
  final String text;
  const UserTitle({super.key,required this.text,required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.secondary
        ),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        padding: const EdgeInsets.all(25),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 20,),
            Text(text)
          ],
        ),
      ),
    );
  }
}