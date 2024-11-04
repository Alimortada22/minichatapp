import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class VisableFabState extends StatefulWidget {
  const VisableFabState(
      {super.key, required this.scrollController, required this.scrooldown});
  final ScrollController scrollController;
  final bool Function()? scrooldown;

  @override
  State<VisableFabState> createState() => _VisableFabStateState();
}

class _VisableFabStateState extends State<VisableFabState> {
  bool isvisable = false;
  void isdown(bool isdown) {
    setState(() {
      isvisable = isdown;
    });
  }

  @override
  void initState() {
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (isvisable == false) {
          setState(() {
            isvisable = true;
          });
        }
      } else if (widget.scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isvisable == true) {
          setState(() {
            isvisable = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
      shape: BoxShape.circle
    ),
            margin: const EdgeInsets.only(bottom: 150,right: 280),
      child: Visibility(
          visible: isvisable,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                isvisable = widget.scrooldown!();
              });
            },
            backgroundColor: Colors.green.withOpacity(0.6),
            child: const Icon(
              Icons.arrow_downward,
              color: Colors.white,
            ),
          )),
    );
  }
}
