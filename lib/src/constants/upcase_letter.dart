String convertToUppercase(String input) {
  if (input.isEmpty) return input;

  final firstChar = input.substring(0, 1).toUpperCase();
  final remainingChars = input.substring(1);

  return '$firstChar$remainingChars';
}
