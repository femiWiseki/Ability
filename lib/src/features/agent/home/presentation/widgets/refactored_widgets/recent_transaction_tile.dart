import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/upcase_letter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class RecentTransactionTile extends ConsumerWidget {
  final String title;
  final String dateTime;
  final String amount;
  final String status;
  final IconData icon;
  final Color iconColor;
  final Color statusColor;
  final void Function()? onTap;
  const RecentTransactionTile({
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.status,
    required this.icon,
    required this.iconColor,
    required this.statusColor,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 65,
        width: double.maxFinite,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 24.51,
                  width: 23.61,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kPrimary.withOpacity(0.1)),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 5.45),
                SizedBox(
                  width: 298.66,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            convertToUppercase(title),
                            style: AppStyleGilroy.kFontW5
                                .copyWith(fontSize: 12.71),
                          ),
                          Text(
                            NumberFormat.currency(
                                    locale: 'en_NG',
                                    decimalDigits: 2,
                                    symbol: '₦')
                                .format(double.parse(amount)),
                            style: AppStyleRoboto.kFontW6
                                .copyWith(fontSize: 10.89),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateTime,
                            style: AppStyleGilroy.kFontW6.copyWith(
                                fontSize: 7.26,
                                color: kBlack2.withOpacity(0.6)),
                          ),
                          Text(
                            status,
                            style: AppStyleGilroy.kFontW6
                                .copyWith(fontSize: 10.89, color: statusColor),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              child: Divider(
                thickness: 1,
                color: kGrey3.withOpacity(0.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
