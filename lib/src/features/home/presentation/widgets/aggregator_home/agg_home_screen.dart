// ignore_for_file: must_be_immutable

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/home/presentation/widgets/aggregator_home/agg_home_screen_bar.dart';
import 'package:ability/src/features/home/presentation/widgets/refactored_widgets/recent_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggHomeScreen extends ConsumerWidget {
  AggHomeScreen({super.key});
  var currentBalance = '500,000.00';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: Column(
        children: [
          AggHomeScreenBar(currentBalance: currentBalance),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 15.84, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent transaction',
                  style: AppStyleGilroy.kFontW6.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 5.05),
                Container(
                    width: double.maxFinite,
                    height: 348,
                    color: kWhite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const RecentTransactionTile();
                        }))
              ],
            ),
          ),
          // AbilityButton(
          //     title: 'Logout',
          //     onPressed: () {
          //       AgentPreference.clearAccessToken().then((value) {
          //         PageNavigator(ctx: context).nextPageOnly(
          //             page: AgentLoginScreen(
          //                 ValidationHelper(), AgentController()));
          //       });
          //     }),
        ],
      ),
    );
  }
}
