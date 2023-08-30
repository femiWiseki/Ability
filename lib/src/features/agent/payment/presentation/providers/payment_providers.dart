import 'package:ability/src/features/agent/payment/application/pay_all_bills_service.dart';
import 'package:ability/src/features/agent/payment/application/buy_data_service.dart';
import 'package:ability/src/features/agent/payment/application/electricity_list_service.dart';
import 'package:ability/src/features/agent/payment/application/get_data_service.dart';
import 'package:ability/src/features/agent/payment/application/resolve_electricity_service.dart';
import 'package:ability/src/features/agent/payment/domain/data_bundle_model.dart';
import 'package:ability/src/features/agent/payment/domain/electricity_list_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectedDataNetwork = StateProvider.autoDispose<String>((ref) => '');
final selectedDataAmount = StateProvider.autoDispose<String>((ref) => '');
final selectedDataPlan = StateProvider.autoDispose<String>((ref) => '');
final selectedDataPlanName = StateProvider<String>((ref) => '');
final selectedRowProvider = StateProvider<int>((ref) => -1);
final selectedElectProvider = StateProvider.autoDispose<String>((ref) => '');

final loadingPayAllBills = StateNotifierProvider<PayAllBillsService, bool>(
    (ref) => PayAllBillsService());

final loadingBuyData =
    StateNotifierProvider<BuyDataService, bool>((ref) => BuyDataService());

// Data List
final dataBundleProvider =
    StateProvider<GetDataService>((ref) => GetDataService());

final getDataProvider = FutureProvider.autoDispose<DataBundleModel>((ref) {
  final ntw = ref.watch(dataBundleProvider);
  return ntw.getData();
});

// Electricity List

final loadingResolveElectricity =
    StateNotifierProvider<ResolveElectricityService, bool>(
        (ref) => ResolveElectricityService());

final electricityListProvider =
    StateProvider<ElectricityListService>((ref) => ElectricityListService());

final getElectricityListProvider =
    FutureProvider.autoDispose<ElectricityListModel>((ref) {
  final list = ref.watch(electricityListProvider);

  return list.electricityList();
});
