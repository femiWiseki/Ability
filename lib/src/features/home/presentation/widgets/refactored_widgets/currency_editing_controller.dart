import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyEditingController extends TextEditingController {
  final Function(double) onValueChange;
  final double initialValue;

  CurrencyEditingController(
      {required this.initialValue, required this.onValueChange})
      : super(text: initialValue.toString());

  @override
  TextSpan buildTextSpan(
      {BuildContext? context, TextStyle? style, bool? withComposing}) {
    final formattedText = NumberFormat.currency(locale: 'en_NG', symbol: '₦')
        .format(double.parse(text));
    return TextSpan(
        text: formattedText,
        style: AppStyleRoboto.kFontW6.copyWith(fontSize: 25, color: kBlack2));
  }

  @override
  set value(TextEditingValue newValue) {
    final newDigits = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    final newValueWithLeadingZeroes = newDigits.padLeft(2, '0');
    final double newValueAsDouble =
        double.parse(newValueWithLeadingZeroes) / 100;

    onValueChange(newValueAsDouble);

    final newSelection =
        TextSelection.collapsed(offset: newValueWithLeadingZeroes.length);
    final newTextValue = TextEditingValue(
      text: newValueWithLeadingZeroes,
      selection: newSelection,
      composing: newValue.composing,
    );
    super.value = newTextValue;
  }
}
