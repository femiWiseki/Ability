import 'package:ability/src/features/aggregator/commission/application/services/commission_service.dart';
import 'package:ability/src/features/aggregator/commission/domain/models/commission_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hideTotalCommmission = StateProvider<bool>((ref) => false);

// This provider is used to get the Agg commission infomation
final aggCommissionPovider =
    StateProvider<AggCommissionService>((ref) => AggCommissionService());

final getAggCommissionProvider =
    FutureProvider.autoDispose<CommissionModel>((ref) {
  final aggCommission = ref.watch(aggCommissionPovider);

  return aggCommission.commissionService();
});
