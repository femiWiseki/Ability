// ignore_for_file: must_be_immutable

import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/routers.dart';
import 'package:ability/src/features/agent/transfer/presentation/controllers/transfer_controller.dart';
import 'package:ability/src/features/agent/transfer/presentation/widgets/agt_beneficiary/agt_transfer_tobene2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgtTransferToBeneficiary1 extends ConsumerWidget {
  AgtTransferToBeneficiary1({super.key});

  List<Map<String, dynamic>> bankAccounts = [
    {
      'bankName': 'Bank A',
      'accName': 'Bola Tinubu',
      'accNumber': '1234567890',
    },
    {
      'bankName': 'Bank B',
      'accName': 'Dapo Abiodun',
      'accNumber': '0987654321',
    },
    {
      'bankName': 'Bank C',
      'accName': 'Sanwo Olu',
      'accNumber': '2468135790',
    },
    {
      'bankName': 'Bank D',
      'accName': 'Yaya Bello',
      'accNumber': '2468135734',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bankDetails = ref.watch(getBankDetailsProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
          child: Column(
            children: [
              const AppHeader(heading: 'Transfer to Beneficiary'),
              const SizedBox(height: 53.89),
              Expanded(
                child: ListView.builder(
                    itemCount: bankAccounts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: InkWell(
                          onTap: () {
                            PageNavigator(ctx: context).nextPage(
                                page: AgtTransferToBeneficiary2(
                              TransferController(),
                              bankName: bankAccounts[index]['bankName'],
                              accountNumber: bankAccounts[index]['accNumber'],
                              accountName: bankAccounts[index]['accName'],
                            ));
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 250,
                                  height: 44,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        '${bankAccounts[index]['accName']}',
                                        style: AppStyleGilroy.kFontW6.copyWith(
                                            fontSize: 16, color: kGrey24),
                                      ),
                                      Text(
                                        "${bankAccounts[index]['accNumber']} ${bankAccounts[index]['bankName']}",
                                        style: AppStyleGilroy.kFontW5.copyWith(
                                            fontSize: 10, color: kBlack2),
                                      )
                                    ],
                                  ),
                                ),
                                const ClipOval(
                                  child: CircleAvatar(),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
