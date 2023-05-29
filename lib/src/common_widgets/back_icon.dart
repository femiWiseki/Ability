import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 33,
          height: 33,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: kWhite),
          child: Icon(
            Icons.arrow_back_rounded,
            color: color ?? kPrimary,
          ),
        ),
      ),
    );
  }
}
