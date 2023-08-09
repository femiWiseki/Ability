import 'package:ability/src/features/agent/home/application/services/agt_profile_service.dart';
import 'package:ability/src/features/agent/home/application/services/trans_history_service.dart';
import 'package:ability/src/features/agent/home/application/services/withdrawal_history_service.dart';
import 'package:ability/src/features/agent/home/domain/models/agt_profile_model.dart';
import 'package:ability/src/features/agent/home/domain/models/agt_trans_history_model.dart';
import 'package:ability/src/features/agent/home/domain/models/withdrawal_history_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hideCurrentBalance = StateProvider<bool>((ref) => false);
final walletAmountProvider = StateProvider((ref) => '');

/// This provider is used to get all agent transaction history
final agtTransHistoryPovider =
    StateProvider<AgtTransHistoryService>((ref) => AgtTransHistoryService());

final getAgtTransHistoryProvider =
    FutureProvider.autoDispose<AgtTransHIstoryModel>((ref) {
  final transHistory = ref.watch(agtTransHistoryPovider);

  return transHistory.agtTransHistoryService();
});

/// This provider is used to get all agent transaction history
final agtWithdrawalHistoryPovider = StateProvider<AgtWithdrawalHistoryService>(
    (ref) => AgtWithdrawalHistoryService());

final getAgtWithdrawalHistoryProvider =
    FutureProvider.autoDispose<AgtWithdrawalHistoryModel>((ref) {
  final withdrawalHistory = ref.watch(agtWithdrawalHistoryPovider);

  return withdrawalHistory.agtTransHistoryService();
});

/// This provider is used to get the Agent profile infomation
final agtProfileName = StateProvider<String>((ref) => '');
final agtProfilePovider =
    StateProvider<AgtProfileService>((ref) => AgtProfileService());

final getAgtProfileProvider =
    FutureProvider.autoDispose<AgtProfileModel>((ref) {
  final agtProfile = ref.watch(agtProfilePovider);

  return agtProfile.agtProfileService();
});
