import 'package:ability/src/features/profile/application/file_format_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hideCurrentBalance = StateProvider<bool>((ref) => false);
final onBiometrics = StateProvider<bool>((ref) => false);
final fileFormatProvider = StateNotifierProvider((ref) => FileFormatNotifier());
