import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/payment/presentation/controllers/payment_controller.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/airtime_screens/buy_airtime.dart';
import 'package:ability/src/features/agent/payment/presentation/widgets/data_screens/buy_data.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_beneficiary/agt_transfer_tobene1.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_transfer/agt_transfer_tobank.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/refactored_widgets/transfer_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtPaymentScreen extends ConsumerWidget {
  const AgtPaymentScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payments',
                style: AppStyleInter.kFontW6.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'How would you like to pay',
                style: AppStyleInter.kFontW6.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 76.89),
              Container(
                height: 400,
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(31, 12, 31, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.7), color: kWhite),
                child: Column(
                  children: [
                    TransferItemTile(
                      title: 'Pay bills',
                      onTap: () async {
                        // PageNavigator(ctx: context).nextPage(
                        //     page: AgtTransferToBank(TransferController()));
                      },
                    ),
                    const Divider(
                      color: kGrey3,
                      thickness: 1,
                    ),
                    TransferItemTile(
                      title: 'Corporate Billers',
                      onTap: () {
                        // PageNavigator(ctx: context)
                        //     .nextPage(page: AgtTransferToBeneficiary1());
                      },
                    ),
                    const Divider(
                      color: kGrey3,
                      thickness: 1,
                    ),
                    TransferItemTile(
                      title: 'Buy Airtime',
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: BuyAirtime(AgtPaymentController()));
                      },
                    ),
                    const Divider(
                      color: kGrey3,
                      thickness: 1,
                    ),
                    TransferItemTile(
                      title: 'Buy Data',
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: BuyData(AgtPaymentController()));
                      },
                    ),
                    const Divider(
                      color: kGrey3,
                      thickness: 1,
                    ),
                    TransferItemTile(
                      title: 'Schedule Payment',
                      onTap: () {
                        // PageNavigator(ctx: context)
                        //     .nextPage(page: AgtTransferToBeneficiary1());
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
