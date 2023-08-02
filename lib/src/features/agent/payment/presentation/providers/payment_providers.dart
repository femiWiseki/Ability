import 'package:ability/src/features/agent/payment/application/buy_%20airtime_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingBuyAirtime = StateNotifierProvider<BuyAirtimeService, bool>(
    (ref) => BuyAirtimeService());
