import 'package:ability/src/features/agent/profile/application/services/passcode_services/agt_resetnew_service.dart';
import 'package:ability/src/features/agent/profile/application/services/passcode_services/agt_resetpc_service.dart';
import 'package:ability/src/features/agent/profile/application/services/passcode_services/agt_verifypc_service.dart';
import 'package:ability/src/features/agent/profile/application/services/file_format_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final hideCurrentBalance = StateProvider<bool>((ref) => false);
final onBiometrics = StateProvider<bool>((ref) => false);
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
