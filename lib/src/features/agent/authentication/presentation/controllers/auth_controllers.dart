import 'package:flutter/material.dart';

class AgentController {
  // Signup
  final signupName = TextEditingController();
  final signupEmail = TextEditingController();
  final signupPhone = TextEditingController();
  final signupBVN = TextEditingController();
  final signupCreatePin = TextEditingController();
  final signupConfirmPin = TextEditingController();
  final signupOTPPin = TextEditingController();
  final signupPasscode = TextEditingController();

// Login
  final loginPhoneNumber = TextEditingController();
  final loginPassword = TextEditingController();
  final loginPasscode = TextEditingController();

// // Reset Pin
  final pinRestEmail = TextEditingController();
  final inputNewPinOTP = TextEditingController();
  final resetPassword = TextEditingController();
  final confirmResetPassword = TextEditingController();

// Change Passcode
  final oldPasscode = TextEditingController();
  final newPasscode = TextEditingController();
  final confirmNewPasscode = TextEditingController();

// Reset Passcode
  final resetPasscode = TextEditingController();
  final verifyOTPPasscode = TextEditingController();
  final resetNewPasscode = TextEditingController();
}
