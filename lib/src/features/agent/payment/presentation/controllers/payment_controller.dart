import 'package:flutter/material.dart';

class AgtPaymentController {
  // Airtime
  final airtimePhoneNumber = TextEditingController();
  late TextEditingController airtimeAmount = TextEditingController();
  final airtimePasscode = TextEditingController();

// Data
  final dataPhoneNumber = TextEditingController();
  final dataAmount = TextEditingController();
  final dataPasscode = TextEditingController();

// Electricity
  final electricityMeterNumber = TextEditingController();
  final electricityPasscode = TextEditingController();
  late TextEditingController electricityAmount = TextEditingController();

  // Cable
  final cableNumber = TextEditingController();
  final cablePasscode = TextEditingController();
  late TextEditingController cableAmount = TextEditingController();
}
