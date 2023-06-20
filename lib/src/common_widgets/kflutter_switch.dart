import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class KFlutterSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool) onToggle;
  const KFlutterSwitch({
    required this.onToggle,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 22,
      height: 14,
      toggleSize: 7.0,
      padding: 3,
      inactiveColor: kPrimary,
      activeColor: kPrimary,
      activeToggleColor: kWhite,
      value: value,
      onToggle: onToggle,
    );
  }
}
