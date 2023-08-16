import 'dart:math';

String generateRandomString(int length) {
  final Random random = Random();
  const int startAsciiCode = 97; // ASCII code for 'a'
  const int endAsciiCode = 122; // ASCII code for 'z'

  // Generate a list of random character codes within the specified range
  final List<int> charCodes = List.generate(
    length,
    (index) =>
        random.nextInt(endAsciiCode - startAsciiCode + 1) + startAsciiCode,
  );

  // Convert the character codes to a string
  final String randomString = String.fromCharCodes(charCodes);

  return randomString;
}
