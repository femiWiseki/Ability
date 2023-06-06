import 'package:ability/src/features/authentication/application/services/create_account_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loadingAgentCreateAccount =
    StateNotifierProvider<AgentCreateAccountService, bool>(
        (ref) => AgentCreateAccountService());

final loadingAggregatorCreateAccount =
    StateNotifierProvider<AgentCreateAccountService, bool>(
        (ref) => AgentCreateAccountService());
// final loadingVerifyNumberProvider =
//     StateNotifierProvider<PhoneVerificationService, bool>(
//         (ref) => PhoneVerificationService());

// final loadingRegisterProvider =
//     StateNotifierProvider<RegisterService, bool>((ref) => RegisterService());

// final loadingEmailVerificationProvider =
//     StateNotifierProvider<EmailVerificationService, bool>(
//         (ref) => EmailVerificationService());

// final loadingBVNNumberProvider =
//     StateNotifierProvider<BVNVerificationService, bool>(
//         (ref) => BVNVerificationService());

// final loadingSetLoginPinProvider =
//     StateNotifierProvider<SetLoginPinService, bool>(
//         (ref) => SetLoginPinService());

// final loadingSetTransactionPinProvider =
//     StateNotifierProvider<SetTransactionPinService, bool>(
//         (ref) => SetTransactionPinService());

// final loadingLoginProvider =
//     StateNotifierProvider<LoginService, bool>((ref) => LoginService());

// final loadingVerifyLoginProvider =
//     StateNotifierProvider<VerifyLoginService, bool>(
//         (ref) => VerifyLoginService());

// final loadingForgotPasswordProvider =
//     StateNotifierProvider<ForgotPasswordService, bool>(
//         (ref) => ForgotPasswordService());

// final loadingVerifyPasswordProvider =
//     StateNotifierProvider<VerifyPasswordService, bool>(
//         (ref) => VerifyPasswordService());

// final loadingNewPasswordProvider =
//     StateNotifierProvider<NewPasswordService, bool>(
//         (ref) => NewPasswordService());

final savePasswordProvider = StateProvider((ref) => false);

final hidePasswordProvider = StateProvider((ref) => true);

final hidePasswordProvider2 = StateProvider((ref) => true);

final hasErrorProvider = StateProvider((ref) => false);

final isEditingProvider = StateProvider((ref) => false);

final isAgentServiceProvider = StateProvider<bool>((ref) => true);

final isCreateAccountProvider = StateProvider<bool>((ref) => true);

// final phoneRegistrationProvider = Provider((ref) => PhoneRegistrationService());
