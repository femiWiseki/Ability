import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/features/aggregator/commission/domain/models/commission_model.dart';
import 'package:ability/src/features/aggregator/commission/presentation/providers/commission_providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CommissionCard extends ConsumerWidget {
  const CommissionCard({
    super.key,
    required this.aggCom,
  });

  final AsyncValue<CommissionModel> aggCom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 150,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: kPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Total Commission',
          style:
              AppStyleGilroy.kFontW5.copyWith(fontSize: 16.53, color: kWhite),
        ),
        const SizedBox(height: 10),
        aggCom.when(
            data: (data) {
              var totalCommmission = NumberFormat.currency(
                      locale: 'en_NG', decimalDigits: 2, symbol: '₦')
                  .format(data.data.totalCommision);
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " ${ref.watch(hideTotalCommmission) ? totalCommmission : '*******'} ",
                    style: AppStyleRoboto.kFontW7
                        .copyWith(fontSize: 23, color: kWhite),
                  ),
                  GestureDetector(
                    onTap: () {
                      ref.read(hideTotalCommmission.notifier).state =
                          !ref.read(hideTotalCommmission.notifier).state;
                    },
                    child: ref.watch(hideTotalCommmission)
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
      ]),
    );
  }
}
