import 'dart:io';

import 'package:ability/src/features/agent/profile/application/services/agt_acc_statement_service.dart';
import 'package:ability/src/features/agent/profile/application/services/agt_acc_verification_service.dart';
import 'package:ability/src/features/agent/profile/application/services/passcode_services/agt_resetnew_service.dart';
import 'package:ability/src/features/agent/profile/application/services/passcode_services/agt_resetpc_service.dart';
import 'package:ability/src/features/agent/profile/application/services/passcode_services/agt_verifypc_service.dart';
import 'package:ability/src/features/agent/profile/application/services/file_format_service.dart';
import 'package:ability/src/features/agent/profile/presentation/controllers/profile_controllers.dart';
import 'package:ability/src/utils/user_preference/user_preference.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final hideCurrentBalance = StateProvider<bool>((ref) => false);

// final onBiometrics = StateProvider<bool>((ref) => false);
final fingerBiometricsProvider = StateProvider<bool>((ref) {
  return AgentPreference.getFingerBiometrics();
});

final fileFormatProvider = StateNotifierProvider((ref) => FileFormatNotifier());

final loadingAgtResetPasscode =
    StateNotifierProvider<AgtResetPasscodeService, bool>(
        (ref) => AgtResetPasscodeService());

final loadingAgtVerifyPasscode =
    StateNotifierProvider<AgtVerifyPasscodeService, bool>(
        (ref) => AgtVerifyPasscodeService());

final loadingAgtResetNewPasscode =
    StateNotifierProvider<AgtResetNewPasscodeService, bool>(
        (ref) => AgtResetNewPasscodeService());

final loadingAgtAccStatemt =
    StateNotifierProvider<AgtAccStatementService, bool>(
        (ref) => AgtAccStatementService());

final loadingAgtAccVerification =
    StateNotifierProvider<AgtAccVerificationService, bool>(
        (ref) => AgtAccVerificationService());

final imageProvider =
    StateNotifierProvider.autoDispose<AgtProfileController, File>(
        (ref) => AgtProfileController());

final uploadPhotoProvider = StateNotifierProvider<AgtProfileController, File>(
    (ref) => AgtProfileController());
