import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class AgtHomeScreenBar extends ConsumerWidget {
  const AgtHomeScreenBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agtProfile = ref.watch(getAgtProfileProvider);
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
                    agtProfile.when(
                        data: (data) {
                          return Text(
                            data.data.data.name,
                            style: AppStyleGilroy.kFontW5.copyWith(
                                fontSize: 11.02,
                                color: kWhite.withOpacity(0.9)),
                          );
                        },
                        error: (e, s) => const Text(''),
                        loading: () => const Text('.....')),
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
            agtProfile.when(
                data: (data) {
                  var currentBalance = NumberFormat.currency(
                          locale: 'en_NG', decimalDigits: 2, symbol: '₦')
                      .format(data.data.data.walletBalance);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " ${ref.watch(hideCurrentBalance) ? currentBalance : '*******'} ",
                        style: AppStyleRoboto.kFontW7
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
                  );
                },
                error: ((error, stackTrace) => const Text('')),
                loading: () => const Text('......')),
            const SizedBox(height: 43.7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AbilityButton(
                  onPressed: () {
                    final indexNumber = StateProvider<int>((ref) => 1);
                    PageNavigator(ctx: context).nextPage(
                        page: AgtBottomNavBar(indexProvider: indexNumber));
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
                        'Send Money',
                        style: AppStyleGilroy.kFontW7.copyWith(fontSize: 12.86),
                      ),
                    ],
                  ),
                ),
                AbilityButton(
                  onPressed: () {
                    final indexNumber = StateProvider<int>((ref) => 2);
                    PageNavigator(ctx: context).nextPage(
                        page: AgtBottomNavBar(indexProvider: indexNumber));
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
                        'Bill Payment',
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
