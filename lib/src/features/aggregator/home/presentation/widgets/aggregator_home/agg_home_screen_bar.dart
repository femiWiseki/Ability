import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/aggregator/home/presentation/widgets/aggregator_home/agg_payment_gateway.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class AggHomeScreenBar extends ConsumerWidget {
  const AggHomeScreenBar({
    super.key,
    required this.currentBalance,
  });

  final String currentBalance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 333.32,
      width: double.maxFinite,
      color: kPrimary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 59.09, 24, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Account',
                      style: AppStyleGilroy.kFontW6.copyWith(
                          fontSize: 18.36, color: kWhite.withOpacity(0.9)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Hi Ayobami!',
                      style: AppStyleGilroy.kFontW5.copyWith(
                          fontSize: 11.02, color: kWhite.withOpacity(0.9)),
                    )
                  ],
                ),
                ClipOval(
                  child: CircleAvatar(
                    radius: 22,
                    child: Image.asset('assets/images/profilePics.png'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 35.18),
            Text(
              'Current Balance',
              style: AppStyleGilroy.kFontW5
                  .copyWith(fontSize: 16.53, color: kWhite),
            ),
            const SizedBox(height: 16.48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " ${ref.watch(hideCurrentBalance) ? '#$currentBalance' : '*******'} ",
                  style: AppStyleGilroy.kFontW7
                      .copyWith(fontSize: 27.55, color: kWhite),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(hideCurrentBalance.notifier).state =
                        !ref.read(hideCurrentBalance.notifier).state;
                  },
                  child: ref.watch(hideCurrentBalance)
                      ? const Icon(
                          Icons.visibility_outlined,
                          color: kWhite,
                          size: 30,
                        )
                      : const Icon(
                          Icons.visibility_off_outlined,
                          color: kWhite,
                          size: 30,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 43.7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AbilityButton(
                  onPressed: () {
                    PageNavigator(ctx: context)
                        .nextPage(page: const AggPaymentGateway());
                  },
                  height: 44,
                  width: 167,
                  borderRadius: 7.35,
                  buttonColor: kWhite,
                  borderColor: kWhite,
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.add_circle,
                        color: kBlack,
                      ),
                      const SizedBox(width: 8.26),
                      Text(
                        'Fund Wallet',
                        style: AppStyleGilroy.kFontW7.copyWith(fontSize: 12.86),
                      ),
                    ],
                  ),
                ),
                AbilityButton(
                  onPressed: () {},
                  height: 44,
                  width: 167,
                  borderRadius: 7.35,
                  buttonColor: kGrey2,
                  borderColor: kGrey2,
                  child: Row(
                    children: [
                      const Icon(
                        Iconsax.add_circle,
                        color: kBlack,
                      ),
                      const SizedBox(width: 8.26),
                      Text(
                        'Add Agent',
                        style: AppStyleGilroy.kFontW7.copyWith(fontSize: 12.86),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
