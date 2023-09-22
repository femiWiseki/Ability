// ignore_for_file: must_be_immutable

import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/aggregator/home/presentation/widgets/refactored_widgets/agg_home_screen_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AggHomeScreen extends ConsumerWidget {
  const AggHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AggHomeScreenBar(),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: kWhite,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Text('');
                          // return const RecentTransactionTile();
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
