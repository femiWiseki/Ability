import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/home/presentation/controllers/home_controllers.dart';
import 'package:ability/src/features/home/presentation/widgets/aggregator_home/agg_enter_amount.dart';
import 'package:ability/src/features/home/presentation/widgets/refactored_widgets/coming_soonbox.dart';
import 'package:ability/src/features/home/presentation/widgets/refactored_widgets/general_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtPaymentGateway extends ConsumerWidget {
  const AgtPaymentGateway({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 138, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose your payment geteway',
              style:
                  AppStyleGilroy.kFontW7.copyWith(fontSize: 20, color: kBlack2),
            ),
            const SizedBox(height: 9),
            Text(
              'Complete your verification to use all the app features',
              style: AppStyleGilroy.kFontW6
                  .copyWith(fontSize: 12, color: kBlack2.withOpacity(0.8)),
            ),
            const SizedBox(height: 43),
            Container(
              height: 306,
              width: 345.05,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.7), color: kWhite),
              child: Column(
                children: [
                  GeneralTile(
                      prefixIconPath: 'assets/icons/card.svg',
                      title: 'Card',
                      onTap: () {
                        PageNavigator(ctx: context)
                            .nextPage(page: AggEnterAmount(HomeControllers()));
                      }),
                  const Divider(thickness: 1, color: kGrey3),
                  GeneralTile(
                      prefixIconPath: 'assets/icons/bank.svg',
                      title: 'Bank',
                      suffixIcons: const ComingSoonBox(),
                      onTap: () {}),
                  const Divider(thickness: 1, color: kGrey3),
                  GeneralTile(
                      prefixIconPath: 'assets/icons/bank.svg',
                      title: 'Transfer',
                      suffixIcons: const ComingSoonBox(),
                      onTap: () {}),
                  const Divider(thickness: 1, color: kGrey3),
                  GeneralTile(
                      prefixIconPath: 'assets/icons/qr_code.svg',
                      title: 'QR Code',
                      suffixIcons: const ComingSoonBox(),
                      onTap: () {}),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
