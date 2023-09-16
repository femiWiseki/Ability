import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/aggregator/authentication/presentation/widgets/landing_page.dart';
import 'package:flutter/material.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({
    Key? key,
    this.color,
    this.navigateTo,
  }) : super(key: key);

  final Color? color;
  final void Function()? navigateTo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: InkWell(
        onTap: navigateTo ?? () {
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

class BackIcon2 extends StatelessWidget {
  const BackIcon2({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: InkWell(
        onTap: (){                    PageNavigator(ctx: context).nextPage(page: const LandingPage());
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