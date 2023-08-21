import 'package:ability/src/features/agent/payment/application/buy_airtime_service.dart';
import 'package:ability/src/features/agent/payment/application/buy_data_service.dart';
import 'package:ability/src/features/agent/payment/application/get_data_service.dart';
import 'package:ability/src/features/agent/payment/domain/data_bundle_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedDataNetwork = StateProvider.autoDispose<String>((ref) => '');
final selectedDataAmount = StateProvider.autoDispose<String>((ref) => '');
final selectedDataPlan = StateProvider.autoDispose<String>((ref) => '');
final selectedDataPlanName = StateProvider<String>((ref) => '');
final selectedRowProvider = StateProvider<int>((ref) => -1);

final loadingBuyAirtime = StateNotifierProvider<BuyAirtimeService, bool>(
    (ref) => BuyAirtimeService());

final loadingBuyData =
    StateNotifierProvider<BuyDataService, bool>((ref) => BuyDataService());

final dataBundleProvider =
    StateProvider<GetDataService>((ref) => GetDataService());

final getDataProvider = FutureProvider.autoDispose<DataBundleModel>((ref) {
  final ntw = ref.watch(dataBundleProvider);
  return ntw.getData();
});
