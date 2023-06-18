import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';

class RecentTransactionTile extends StatelessWidget {
  const RecentTransactionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                child: const Icon(
                  Icons.arrow_downward_rounded,
                  color: kPrimary,
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
                          'Pos Withdrawal',
                          style:
                              AppStyleGilroy.kFontW5.copyWith(fontSize: 12.71),
                        ),
                        Text(
                          '-#4,100',
                          style:
                              AppStyleGilroy.kFontW6.copyWith(fontSize: 10.89),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'May 31, 20:54',
                          style: AppStyleGilroy.kFontW6.copyWith(
                              fontSize: 7.26, color: kBlack2.withOpacity(0.6)),
                        ),
                        Text(
                          'Successful',
                          style: AppStyleGilroy.kFontW6
                              .copyWith(fontSize: 10.89, color: kGreen),
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
    );
  }
}
