import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/inter.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/recent_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class AgtWithdrawalHistory extends ConsumerWidget {
  const AgtWithdrawalHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawalHistory = ref.watch(getAgtWithdrawalHistoryProvider);
    return Scaffold(
      backgroundColor: kAsh1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: Column(
            children: [
              const AppHeader(
                heading: 'Withdrawal History',
                // suffixIcon: InkWell(
                //     onTap: () {},
                //     child: SvgPicture.asset('assets/icons/filter.svg')),
              ),
              const SizedBox(height: 33.11),
              withdrawalHistory.when(
                data: (data) {
                  final historyInfo = data.data.withdrawalNotifications;
                  return Expanded(
                    child: Container(
                      color: kWhite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      child: ListView.builder(
                        itemCount: historyInfo.length,
                        itemBuilder: (context, index) {
                          DateTime historyTime = historyInfo[index].createdAt;
                          String formattedDate =
                              DateFormat('MMM dd, hh:mm').format(historyTime);

                          return RecentTransactionTile(
                              title: historyInfo[index].description.toString(),
                              dateTime: formattedDate,
                              amount: historyInfo[index].amount,
                              status: historyInfo[index]
                                  .responseDescription
                                  .toString());
                        },
                      ),
                    ),
                  );
                },
                error: (e, s) => Text(e.toString()),
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: kWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showMenu() {
  PopupMenuButton(
    itemBuilder: (BuildContext context) => [
      PopupMenuItem(
        child: Column(
          children: [
            Text('First Text'),
            Divider(),
            Text('Second Text'),
          ],
        ),
      ),
    ],
  );
}
