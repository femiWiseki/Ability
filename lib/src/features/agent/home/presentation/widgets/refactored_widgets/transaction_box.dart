import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionBox extends StatelessWidget {
  final Color boxColor;
  final String title;
  final int amount;
  const TransactionBox({
    required this.boxColor,
    required this.title,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 79,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppStyleInter.kFontW5.copyWith(fontSize: 15, color: kWhite),
          ),
          Text(
            NumberFormat.currency(
                    locale: 'en_NG', decimalDigits: 2, symbol: '₦')
                .format(amount),
            style: AppStyleInter.kFontW5.copyWith(fontSize: 15, color: kWhite),
          )
        ],
      ),
    );
  }
}
