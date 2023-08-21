import 'package:ability/src/features/agent/transfer/application/services/banks_details_service.dart';
import 'package:ability/src/features/agent/transfer/application/services/resolve_account_num.dart';
import 'package:ability/src/features/agent/transfer/application/services/saved_bene_service.dart';
import 'package:ability/src/features/agent/transfer/application/services/supply_smart_service.dart';
import 'package:ability/src/features/agent/transfer/application/services/transfer_money_service.dart';
import 'package:ability/src/features/agent/transfer/domain/models/agt_beneficiary_model.dart';
import 'package:ability/src/features/agent/transfer/domain/models/banks_details_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

BuildContext? context;
final agtSaveBeneficiary = StateProvider<bool>((ref) => false);
final saveBeneficiaryProvider = StateProvider((ref) => false);

final loadingAgtBankDetail1 =
    StateNotifierProvider<AgtResolveAccNumService, bool>(
        (ref) => AgtResolveAccNumService());

final loadingAgtBankDetail2 =
    StateNotifierProvider<AgtTransferMoneyService, bool>(
        (ref) => AgtTransferMoneyService());

final bankDetailsProvider =
    StateProvider<AgtResolveAccNumService>((ref) => AgtResolveAccNumService());

final transSupplySmartProvider =
    StateNotifierProvider<AgtSupplySmartService, bool>(
        (ref) => AgtSupplySmartService());

// final getBankDetailsProvider = FutureProvider<ResolveAccNumModel>((ref) {
//   final bankDetails = ref.watch(bankDetailsProvider);

//   return bankDetails.resolveAccNumService(
//       context: context!, bankName: '', accountNumber: '');
// });

/// Get all Beneficiaries
final savedBeneficiaryProvider = StateProvider<AgtSavedBeneficiaryService>(
    (ref) => AgtSavedBeneficiaryService());

final getAgtBeneficiaryProvider = FutureProvider<BeneficiaryModel>((ref) {
  final beneficiary = ref.watch(savedBeneficiaryProvider);

  return beneficiary.agtSavedBeneficiary();
});

/// Get all Banks Details
final banksDetailsProvider =
    StateProvider<AgtBanksDetailsService>((ref) => AgtBanksDetailsService());

final getBanksDetailsProvider = FutureProvider<BanksDetailsModel>((ref) {
  final banks = ref.watch(banksDetailsProvider);

  return banks.banksDetails();
});
