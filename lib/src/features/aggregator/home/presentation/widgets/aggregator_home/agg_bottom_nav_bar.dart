import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/aggregator/commission/presentation/widgets/commission_screen.dart';
import 'package:ability/src/features/aggregator/home/presentation/widgets/aggregator_home/agg_home_screen.dart';
import 'package:ability/src/features/aggregator/home/presentation/widgets/refactored_widgets/icon_bottom_bar.dart';
import 'package:ability/src/features/aggregator/profile/presentation/widgets/aggregator_profile/agg_profile_screen.dart';
import 'package:ability/src/features/aggregator/transfer/presentation/widgets/agg_transfer/agg_transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggBottomNavBar extends ConsumerStatefulWidget {
  final StateProvider<int> indexProvider; // Added indexProvider parameter

  const AggBottomNavBar({
    Key? key,
    required this.indexProvider, // Added indexProvider parameter
  }) : super(key: key);

  @override
  ConsumerState<AggBottomNavBar> createState() => _AggBottomNavBarState();
}

class _AggBottomNavBarState extends ConsumerState<AggBottomNavBar> {
//   @override
//   void initState() {
//     super.initState();
// // Call the function after 5 minutes (300 seconds)
//     Future.delayed(const Duration(minutes: 5), () {
//       showSessionExpiredDialog(context);
//     });
//   }

  final orangeColor = const Color(0xffFF8527);
  final screens = [
    AggHomeScreen(),
    const AggTransferScreen(),
    const CommissionScreen(),
    const AggregatorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[
          ref.watch(widget.indexProvider)], // Access indexProvider from widget
      bottomNavigationBar: BottomAppBar(
        color: kWhite,
        child: SizedBox(
          height: 78.79,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(screens.length, (index) {
                return IconBottomBar(
                  iconTitle: _getScreenTitle(index),
                  iconString1: _getScreenIcon(index),
                  selected: ref.watch(widget.indexProvider) ==
                      index, // Access indexProvider from widget
                  onPressed: () {
                    ref.read(widget.indexProvider.notifier).state =
                        index; // Access indexProvider from widget
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  String _getScreenTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Transfer';
      case 2:
        return 'Commission';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }

  String _getScreenIcon(int index) {
    switch (index) {
      case 0:
        return 'assets/icons/home.svg';
      case 1:
        return 'assets/icons/transfer.svg';
      case 2:
        return 'assets/icons/commission.svg';
      case 3:
        return 'assets/icons/profile.svg';
      default:
        return '';
    }
  }
}
