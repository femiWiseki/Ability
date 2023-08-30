// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:ability/src/common_widgets/ability_button.dart';
import 'package:ability/src/common_widgets/app_header.dart';
import 'package:ability/src/constants/app_text_style/gilroy.dart';
import 'package:ability/src/constants/app_text_style/roboto.dart';
import 'package:ability/src/constants/colors.dart';
import 'package:ability/src/constants/upcase_letter.dart';
import 'package:ability/src/features/agent/home/application/services/resolve_%20dispute_service.dart';
import 'package:ability/src/features/agent/home/presentation/controllers/home_controllers.dart';
import 'package:ability/src/features/agent/home/presentation/providers/home_providers.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/acc_statemt_tile.dart';
import 'package:ability/src/features/agent/home/presentation/widgets/refactored_widgets/raise_dispute_dialog.dart';
import 'package:ability/src/utils/helpers/validation_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class AgtDepositDetails extends ConsumerWidget {
  final String transType;
  final String transAmount;
  final String transDateTime;
  final String transStatus;
  final String sender;
  final String bankName;
  final String bankAccount;
  final String transNumber;
  final String depositType;
  final String sessionId;
  AgtDepositDetails(
      {required this.transType,
      required this.transAmount,
      required this.transDateTime,
      required this.transStatus,
      required this.sender,
      required this.bankName,
      required this.bankAccount,
      required this.transNumber,
      required this.depositType,
      required this.sessionId,
      super.key});

  ScreenshotController screenshotController = ScreenshotController();

  Future<void> captureAndShareScreenshot(Uint8List bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageFile = File('${directory.path}/screenshot.png');
      await imageFile.writeAsBytes(bytes);

      final xFile = XFile(imageFile.path); // Convert to XFile
      await Share.shareXFiles([xFile]);
    } catch (e) {
      print("Error sharing: $e");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kAsh1,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 37, 24, 0),
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(heading: 'Transaction History'),
              const SizedBox(height: 37.11),
              Screenshot(
                controller: screenshotController,
                child: Container(
                  height: 480,
                  width: 380,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25), color: kWhite),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(19, 31, 19, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: Image.asset(
                            'assets/images/smt_sup.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 34.2,
                              child: Row(
                                children: [
                                  Container(
                                    height: 34.1,
                                    width: 32.8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kPrimary.withOpacity(0.1)),
                                    child: const Icon(
                                      Icons.arrow_downward_rounded,
                                      color: kPrimary,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    convertToUppercase(transType),
                                    style: AppStyleGilroy.kFontW5
                                        .copyWith(fontSize: 15.86),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  NumberFormat.currency(
                                          locale: 'en_NG',
                                          decimalDigits: 2,
                                          symbol: '₦')
                                      .format(double.parse(transAmount)),
                                  style: AppStyleRoboto.kFontW6
                                      .copyWith(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  transDateTime,
                                  style: AppStyleGilroy.kFontW5
                                      .copyWith(fontSize: 10, color: kBlack2),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 26.79),
                        const Divider(
                          thickness: 1,
                          color: kGrey3,
                        ),
                        const SizedBox(height: 17.96),
                        AccStatementTile(
                          prefixText: 'Status',
                          suffixText: transStatus,
                          suffixTextColor: kGreen,
                          suffixTextFontSize: 16,
                        ),
                        AccStatementTile(
                            prefixText: 'Sender', suffixText: sender),
                        AccStatementTile(
                            prefixText: 'Bank Name', suffixText: bankName),
                        AccStatementTile(
                            prefixText: 'Bank Account',
                            suffixText: bankAccount),
                        AccStatementTile(
                            prefixText: 'Deposit Type',
                            suffixText: depositType),
                        const SizedBox(height: 18),
                        const Divider(
                          thickness: 1,
                          color: kGrey3,
                        ),
                        AccStatementTile(
                            prefixText: 'Session ID', suffixText: sessionId),
                        AccStatementTile(
                            prefixText: 'Transaction number',
                            suffixText: transNumber),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return RaiseDisputeDialog(
                        ValidationHelper(),
                        disputeController:
                            HomeControllers().airtimeDisputeController,
                        sendDispute: () {
                          ResolveDisputeService().disputeService(
                            context: context,
                            disputeReason: ref.watch(disputeProvider),
                            transactionId: transNumber,
                          );
                        },
                      );
                    },
                  );
                },
                child: Text(
                  'Raise Dispute',
                  style: AppStyleGilroy.kFontW8
                      .copyWith(color: kGreen, fontSize: 18),
                ),
              ),
              const SizedBox(height: 50),
              AbilityButton(
                title: 'Share Receipt',
                onPressed: () async {
                  final imageBytes = await screenshotController.capture();
                  if (imageBytes != null) {
                    await captureAndShareScreenshot(imageBytes);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
