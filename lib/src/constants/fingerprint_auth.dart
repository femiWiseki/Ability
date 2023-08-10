// ignore_for_file: use_build_context_synchronously

import 'package:ability/src/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

// function to check biometric availability and get available biometric types
Future<bool> isBiometricAvailable() async {
  final LocalAuthentication auth = LocalAuthentication();
  final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
  final bool isDeviceSupported = await auth.isDeviceSupported();
  final List<BiometricType> availableBiometrics =
      await auth.getAvailableBiometrics();

  return canAuthenticateWithBiometrics &&
      isDeviceSupported &&
      availableBiometrics.isNotEmpty;
}

// implement the function to perform fingerprint authentication
// Future<bool> authenticateWithBiometrics() async {
//   final LocalAuthentication auth = LocalAuthentication();
//   final bool didAuthenticate = await auth.authenticate(
//     localizedReason: 'Use Biometric to unlock your phone',
//     options: const AuthenticationOptions(biometricOnly: true),
//   );

//   return didAuthenticate;
// }

Future<bool> authenticateWithBiometrics(BuildContext context) async {
  final LocalAuthentication auth = LocalAuthentication();

  try {
    // Show the circular progress indicator while waiting for fingerprint authentication
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const CircularProgressIndicator(
            color: kPrimary,
          ),
        ),
      ),
    );

    final bool didAuthenticate = await auth.authenticate(
      localizedReason: 'Use Biometric to unlock your phone',
      options: const AuthenticationOptions(biometricOnly: true),
    );

    // Delay the dismissal of the AlertDialog by 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Dismiss the AlertDialog
    Navigator.pop(context);

    return didAuthenticate;
  } on PlatformException {
    // Dismiss the AlertDialog in case of an error
    Navigator.pop(context);

    rethrow; // Rethrow the exception for further handling
  }
}

// handle the different error scenarios during authentication
Future<void> handleAuthenticationError(PlatformException e) async {
  if (e.code == auth_error.notAvailable) {
    // Biometric hardware not available on the device.
    print('Biometric authentication not available.');
  } else if (e.code == auth_error.notEnrolled) {
    // Biometric authentication not enrolled on the device.
    print('Biometric authentication not enrolled.');
  } else if (e.code == auth_error.lockedOut ||
      e.code == auth_error.permanentlyLockedOut) {
    // Biometric authentication is locked out due to too many failed attempts.
    print('Biometric authentication locked out.');
  } else {
    // Other errors.
    print('Biometric authentication failed with error: ${e.message}');
  }
}

//  functions to trigger fingerprint authentication
userFingerPrintAuth(
    {required BuildContext context,
    required void Function() proceedAuth}) async {
  final isAvailable = await isBiometricAvailable();

  if (isAvailable) {
    try {
      final authenticated = await authenticateWithBiometrics(context);

      if (authenticated) {
        proceedAuth.call();
        // Authentication successful, proceed with your app logic
        print('Authentication successful!');
      } else {
        // Authentication failed or user cancelled
        print('Authentication failed!');
      }
    } on PlatformException catch (e) {
      handleAuthenticationError(e);
    }
  } else {
    // Biometric authentication not available on this device.
    print('Biometric authentication not available.');
  }
}
