import 'package:hooks_riverpod/hooks_riverpod.dart';

class FileFormatNotifier extends StateNotifier<String> {
  FileFormatNotifier() : super('');

  void selectFormat(String format) {
    state = format;
  }
}
