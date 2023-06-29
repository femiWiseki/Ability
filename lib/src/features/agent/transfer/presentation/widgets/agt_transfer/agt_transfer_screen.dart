import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_beneficiary/agt_transfer_tobene1.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_transfer/agt_transfer_tobank.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/refactored_widgets/transfer_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtTransferScreen extends ConsumerWidget {
  const AgtTransferScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
          child: Column(
            children: [
              Text(
                'Transfer',
                style: AppStyleInter.kFontW6.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 76.89),
              Container(
                height: 166,
                width: double.maxFinite,
                padding: const EdgeInsets.fromLTRB(31, 35, 31, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.7), color: kWhite),
                child: Column(
                  children: [
                    TransferItemTile(
                      title: 'Transfer to Bank',
                      onTap: () async {
                        PageNavigator(ctx: context).nextPage(
                            page: AgtTransferToBank(TransferController()));
                      },
                    ),
                    const SizedBox(height: 23),
                    const Divider(
                      color: kGrey3,
                      thickness: 1,
                    ),
                    const SizedBox(height: 23),
                    TransferItemTile(
                      title: 'Transfer to Beneficiary',
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: AgtTransferToBeneficiary1());
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
