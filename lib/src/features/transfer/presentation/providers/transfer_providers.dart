import 'package:ability/src/features/transfer/application/services/resolve_account_num.dart';
import 'package:ability/src/features/transfer/application/services/transfer_money_service.dart';
import 'package:ability/src/features/transfer/domain/models/resolve_acc_num_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

BuildContext? context;
final agtSaveBeneficiary = StateProvider<bool>((ref) => false);

final loadingAgtBankDetail1 =
    StateNotifierProvider<AgtResolveAccNumService, bool>(
        (ref) => AgtResolveAccNumService());

final loadingAgtBankDetail2 =
    StateNotifierProvider<AgtTransferMoneyService, bool>(
        (ref) => AgtTransferMoneyService());

/// Get bank details provider

final bankDetailsProvider =
    StateProvider<AgtResolveAccNumService>((ref) => AgtResolveAccNumService());

final getBankDetailsProvider = FutureProvider<ResolveAccNumModel>((ref) {
  final bankDetails = ref.watch(bankDetailsProvider);

  return bankDetails.resolveAccNumService(
      context: context!, bankName: '', accountNumber: '');
});
