import 'package:ability/src/features/aggregator/authentication/application/services/forgot_pin_services/input_new_pin_service.dart';
import 'package:ability/src/features/aggregator/authentication/application/services/forgot_pin_services/pin_reset_service.dart';
import 'package:ability/src/features/aggregator/authentication/application/services/login_services/login_service.dart';
import 'package:ability/src/features/aggregator/authentication/application/services/login_services/passcode_login_service.dart';
import 'package:ability/src/features/aggregator/authentication/application/services/signup_services/create_account_service.dart';
import 'package:ability/src/features/aggregator/authentication/application/services/signup_services/passcode_service.dart';
import 'package:ability/src/features/aggregator/authentication/application/services/signup_services/signup_otp_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Aggregator Providers
final loadingAggregatorCreateAccount =
    StateNotifierProvider<AggregatorCreateAccountService, bool>(
        (ref) => AggregatorCreateAccountService());

final loadingAggregatorOTP = StateNotifierProvider<AggregatorOTPService, bool>(
    (ref) => AggregatorOTPService());

final loadingAggregatorPasscode =
    StateNotifierProvider<AggregatorPasscodeService, bool>(
        (ref) => AggregatorPasscodeService());

final loadingAggLoginPasscode =
    StateNotifierProvider<AggPasscodeLoginService, bool>(
        (ref) => AggPasscodeLoginService());

final loadingAggregatorLogin =
    StateNotifierProvider<AggregatorLoginService, bool>(
        (ref) => AggregatorLoginService());

final loadingAggregatorPinRest =
    StateNotifierProvider<AggregatorPinResetService, bool>(
        (ref) => AggregatorPinResetService());

final loadingAggInputNewPin =
    StateNotifierProvider<AggregatorInputNewPinService, bool>(
        (ref) => AggregatorInputNewPinService());

// Other Providers
final aggSavePasswordProvider = StateProvider((ref) => false);

final hidePasswordProvider = StateProvider((ref) => true);

final hidePasswordProvider2 = StateProvider((ref) => true);

final hasErrorProvider = StateProvider((ref) => false);

final isEditingProvider = StateProvider((ref) => false);

final isAgentServiceProvider = StateProvider<bool>((ref) => true);

final isCreateAccountProvider = StateProvider<bool>((ref) => true);

// final phoneRegistrationProvider = Provider((ref) => PhoneRegistrationService());
