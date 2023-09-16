import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/constants/snack_messages.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_bottom_nav_bar.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/agent_home/agt_notifications.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:clipboard/clipboard.dart';
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
      height: 330,
      width: double.maxFinite,
      color: kPrimary,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 59.09, 24, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          final indexNumber = StateProvider((ref) => 3);

                          PageNavigator(ctx: context).nextPage(
                              page:
                                  AgtBottomNavBar(indexProvider: indexNumber));
                        },
                        child: ClipOval(
                          child: CircleAvatar(
                            radius: 22,
                            backgroundImage: agtProfile.when(
                              data: (data) {
                                var profilePhoto =
                                    data.data.data.profilePicture;
                                print(profilePhoto);
                                return NetworkImage(
                                  profilePhoto,
                                );
                              },
                              error: (e, s) => const NetworkImage(''),
                              loading: () => null,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Account',
                            style: AppStyleGilroy.kFontW6.copyWith(
                                fontSize: 18.36,
                                color: kWhite.withOpacity(0.9)),
                          ),
                          agtProfile.when(
                              data: (data) {
                                var agtInfo = data.data.data;
                                var agtName = agtInfo.name;
                                var agtPhoneNumber = agtInfo.phoneNumber;
                                Future.delayed(Duration.zero, () {
                                  ref.read(isVerifiedProvider.notifier).state =
                                      agtInfo.isVerified;
                                  ref.read(isDisabledProvider.notifier).state =
                                      agtInfo.isDisabled.disabled;
                                });

                                AgentPreference.setPhoneNumber(agtPhoneNumber);
                                AgentPreference.setUsername(agtName);
                                return Text(
                                  agtName,
                                  style: AppStyleGilroy.kFontW5.copyWith(
                                      fontSize: 11.02,
                                      color: kWhite.withOpacity(0.9)),
                                );
                              },
                              error: (e, s) => const Text(''),
                              loading: () => const Text('')),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      PageNavigator(ctx: context)
                          .nextPage(page: const AgtNotifications());
                    },
                    child: const Icon(Icons.notifications, color: kWhite))
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Current Balance',
              style: AppStyleGilroy.kFontW5
                  .copyWith(fontSize: 16.53, color: kWhite),
            ),
            const SizedBox(height: 10),
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
                            .copyWith(fontSize: 23, color: kWhite),
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
                                size: 25,
                              )
                            : const Icon(
                                Icons.visibility_off_outlined,
                                color: kWhite,
                                size: 25,
                              ),
                      ),
                    ],
                  );
                },
                error: ((error, stackTrace) => const Text('')),
                loading: () => const Text('')),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                agtProfile.when(
                    data: (data) {
                      var virAccBank = data.data.data.virtualAccountNumber;
                      return SizedBox(
                        width: 180,
                        child: Row(
                          children: [
                            Text(
                              virAccBank,
                              style: AppStyleGilroy.kFontW6
                                  .copyWith(fontSize: 16, color: kWhite),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                FlutterClipboard.copy(virAccBank).then((value) {
                                  successMessage(
                                      context: context, message: 'Copied');
                                });
                              },
                              child: const Icon(
                                Iconsax.copy,
                                size: 20,
                                color: kAsh1,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    error: (e, s) => const Text(''),
                    loading: () => const Text('')),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                agtProfile.when(
                    data: (data) {
                      var virBankName = data.data.data.virtualBankName;
                      return SizedBox(
                        width: 180,
                        child: Text(
                          virBankName,
                          style: AppStyleGilroy.kFontW5
                              .copyWith(fontSize: 15, color: kWhite),
                        ),
                      );
                    },
                    error: (e, s) => const Text(''),
                    loading: () => const Text('')),
              ],
            ),
            const SizedBox(height: 20),
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
