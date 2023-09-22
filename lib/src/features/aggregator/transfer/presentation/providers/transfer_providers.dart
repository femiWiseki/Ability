import 'package:ability/src/features/aggregator/transfer/application/services/agg_resolve_account_num.dart';
import 'package:ability/src/features/aggregator/transfer/application/services/transfer_money_service.dart';
import 'package:ability/src/features/aggregator/transfer/domain/models/resolve_acc_num_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

BuildContext? context;
final AggSaveBeneficiary = StateProvider<bool>((ref) => false);

final loadingAggBankDetail1 =
    StateNotifierProvider<AggResolveAccNumService, bool>(
        (ref) => AggResolveAccNumService());

final loadingAggBankDetail2 =
    StateNotifierProvider<AggTransferMoneyService, bool>(
        (ref) => AggTransferMoneyService());

/// Get bank details provider

final bankDetailsProvider =
    StateProvider<AggResolveAccNumService>((ref) => AggResolveAccNumService());

final getBankDetailsProvider = FutureProvider<ResolveAccNumModel>((ref) {
  final bankDetails = ref.watch(bankDetailsProvider);

  return bankDetails.resolveAccNumService(
      context: context!, bankName: '', accountNumber: '');
});
