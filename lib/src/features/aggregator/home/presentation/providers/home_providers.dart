import 'package:ability/src/features/aggregator/home/application/services/agg_profile_service.dart';
import 'package:ability/src/features/aggregator/home/application/services/trans_history_service.dart';
import 'package:ability/src/features/aggregator/home/domain/models/agg_profile_model.dart';
import 'package:ability/src/features/aggregator/home/domain/models/agg_trans_history_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hideAggCurrentBalance = StateProvider<bool>((ref) => false);
final aggWalletAmountProvider = StateProvider((ref) => '');

// This provider is used to get all agent transaction history
final aggTransHistoryPovider =
    StateProvider<AgtTransHistoryService>((ref) => AgtTransHistoryService());

final getAggTransHistoryProvider = FutureProvider<AgtTransHIstoryModel>((ref) {
  final transHistory = ref.watch(aggTransHistoryPovider);

  return transHistory.agtTransHistoryService();
});

// This provider is used to get the Agent profile infomation
final aggProfilePovider =
    StateProvider<AggProfileService>((ref) => AggProfileService());

final getAggProfileProvider =
    FutureProvider.autoDispose<AggProfileModel>((ref) {
  final aggProfile = ref.watch(aggProfilePovider);

  return aggProfile.aggProfileService();
});
