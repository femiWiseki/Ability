import 'package:ability/src/features/agent/authentication/application/services/forgot_pin_services/input_new_pin_service.dart';
import 'package:ability/src/features/agent/authentication/application/services/forgot_pin_services/pin_reset_service.dart';
import 'package:ability/src/features/agent/authentication/application/services/login_services/login_service.dart';
import 'package:ability/src/features/agent/authentication/application/services/login_services/passcode_login_service.dart';
import 'package:ability/src/features/agent/authentication/application/services/signup_services/create_account_service.dart';
import 'package:ability/src/features/agent/authentication/application/services/signup_services/passcode_service.dart';
import 'package:ability/src/features/agent/authentication/application/services/signup_services/signup_otp_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Agent Providers
final loadingAgentCreateAccount =
    StateNotifierProvider<AgentCreateAccountService, bool>(
        (ref) => AgentCreateAccountService());

final loadingAgentOTP =
    StateNotifierProvider<AgentOTPService, bool>((ref) => AgentOTPService());

final loadingAgentPasscode = StateNotifierProvider<AgentPasscodeService, bool>(
    (ref) => AgentPasscodeService());

final loadingAgentLoginPasscode =
    StateNotifierProvider<AgtPasscodeLoginService, bool>(
        (ref) => AgtPasscodeLoginService());

final loadingAgentLogin = StateNotifierProvider<AgentLoginService, bool>(
    (ref) => AgentLoginService());

final loadingAgentPinRest = StateNotifierProvider<AgentPinResetService, bool>(
    (ref) => AgentPinResetService());

final loadingAgentInputNewPin =
    StateNotifierProvider<AgentInputNewPinService, bool>(
        (ref) => AgentInputNewPinService());

// Other Providers
final savePasswordProvider = StateProvider((ref) => false);

final hidePasswordProvider = StateProvider((ref) => true);

final hidePasswordProvider2 = StateProvider((ref) => true);

final hasErrorProvider = StateProvider((ref) => false);

final isEditingProvider = StateProvider((ref) => false);

final isAgentServiceProvider = StateProvider<bool>((ref) => true);

final isCreateAccountProvider = StateProvider<bool>((ref) => true);

// final phoneRegistrationProvider = Provider((ref) => PhoneRegistrationService());
