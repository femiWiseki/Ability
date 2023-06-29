import 'package:shared_preferences/shared_preferences.dart';

class AgentPreference {
  static late SharedPreferences _preferences;

// Agent preference key
  static const _keyEmail = 'email';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';
  static const _keyPhoneNumber = 'phoneNumber';
  static const _keyAccessToken = 'accessToken';
  static const _keyRefreshToken = 'refreshToken';
  static const _keyRefreshedToken = 'refreshedToken';
  static const _keyId = 'id';
  static const _keyPhoneToken = 'phoneToken';
  static const _keySavedPhoneNumber = 'savedPhoneNumber';
  static const _keySavedPassword = 'savedPassword';
  static const _keyAccountName = 'accountName';
  static const _keyAccountNumber = 'accountNumber';
  static const _keyBankName = 'bankName';
  static const _keyTransferAmount = 'transferAmount';
  static const _keyTransDesc = 'transferDesc';
  static const _keyPasscodeStatus = 'passcodeStatus';

// Initialize SharedPreference
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  /// Save Agent Data
  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static Future setFirstName(String firstname) async =>
      await _preferences.setString(_keyFirstName, firstname);

  static Future setLastName(String lastname) async =>
      await _preferences.setString(_keyLastName, lastname);

  static Future setPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(_keyPhoneNumber, phoneNumber);

  static Future setId(String id) async =>
      await _preferences.setString(_keyId, id);

  static Future setAccessToken(String accessToken) async =>
      await _preferences.setString(_keyAccessToken, accessToken);

  static Future setRefreshToken(String refreshToken) async =>
      await _preferences.setString(_keyRefreshToken, refreshToken);

  static Future setRefreshedToken(String refreshedToken) async =>
      await _preferences.setString(_keyRefreshedToken, refreshedToken);

  static Future setPhoneToken(String phoneToken) async =>
      await _preferences.setString(_keyPhoneToken, phoneToken);

  static Future setSavedPhoneNumber(String savedPhoneNumber) async =>
      await _preferences.setString(_keySavedPhoneNumber, savedPhoneNumber);

  static Future setSavedPassword(String savedPassword) async =>
      await _preferences.setString(_keySavedPassword, savedPassword);

  static Future setAccountName(String accountName) async =>
      await _preferences.setString(_keyAccountName, accountName);

  static Future setAccountNumber(String accountNumber) async =>
      await _preferences.setString(_keyAccountNumber, accountNumber);

  static Future setBankName(String bankName) async =>
      await _preferences.setString(_keyBankName, bankName);

  static Future setTransferAmount(String transferAmount) async =>
      await _preferences.setString(_keyTransferAmount, transferAmount);

  static Future setTransDesc(String transferDesc) async =>
      await _preferences.setString(_keyTransDesc, transferDesc);

  static Future setPasscodeStatus(String passcodeStatus) async =>
      await _preferences.setString(_keyPasscodeStatus, passcodeStatus);

  // Get Agent Data
  static String? getEmail() => _preferences.getString(_keyEmail);

  static String? getFirstName() => _preferences.getString(_keyFirstName);

  static String? getLastName() => _preferences.getString(_keyLastName);

  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  static String? getId() => _preferences.getString(_keyId);

  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static String? getRefreshToken() => _preferences.getString(_keyRefreshToken);

  static String? getRefreshedToken() =>
      _preferences.getString(_keyRefreshedToken);

  static String? getPhoneToken() => _preferences.getString(_keyPhoneToken);

  static String? getAccountName() => _preferences.getString(_keyAccountName);

  static String? getTransferAmount() =>
      _preferences.getString(_keyTransferAmount);

  static String? getTransDesc() => _preferences.getString(_keyTransDesc);

  static String? getAccountNumber() =>
      _preferences.getString(_keyAccountNumber);

  static String? getBankName() => _preferences.getString(_keyBankName);

  static String? getSavedPhoneNumber() =>
      _preferences.getString(_keySavedPhoneNumber);

  static String? getSavedPassword() =>
      _preferences.getString(_keySavedPassword);

  static String? getPasscodeStatus() =>
      _preferences.getString(_keyPasscodeStatus);

  /// Clear Agent Token when logged out..
  static Future logoutUser() async {
    await _preferences.remove(_keyPhoneToken);
  }

  // Clear Agent Saved login credentials
  static Future clearLoginCredentials() async {
    await _preferences.remove(_keySavedPhoneNumber);
    await _preferences.remove(_keySavedPassword);
  }

  /// Clear AccountName..
  static Future clearAccountName() async {
    await _preferences.remove(_keyAccountName);
  }
}

// Aggregator Preference Class
class AggregatorPreference {
  static late SharedPreferences _preferences;

// Agent preference key
  static const _keyEmail = 'email';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';
  static const _keyPhoneNumber = 'phoneNumber';
  static const _keyAccessToken = 'accessToken';
  static const _keyId = 'id';
  static const _keyPhoneToken = 'phoneToken';
  static const _keySavedPhoneNumber = 'savedPhoneNumber';
  static const _keySavedPassword = 'savedPassword';
  static const _keyPasscodeStatus = 'passcodeStatus';

// Initialize SharedPreference
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  /// Save Agent Data
  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static Future setFirstName(String firstname) async =>
      await _preferences.setString(_keyFirstName, firstname);

  static Future setLastName(String lastname) async =>
      await _preferences.setString(_keyLastName, lastname);

  static Future setPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(_keyPhoneNumber, phoneNumber);

  static Future setId(String id) async =>
      await _preferences.setString(_keyId, id);

  static Future setAccessToken(String accessToken) async =>
      await _preferences.setString(_keyAccessToken, accessToken);

  static Future setPhoneToken(String phoneToken) async =>
      await _preferences.setString(_keyPhoneToken, phoneToken);

  static Future setSavedPhoneNumber(String savedPhoneNumber) async =>
      await _preferences.setString(_keySavedPhoneNumber, savedPhoneNumber);

  static Future setSavedPassword(String savedPassword) async =>
      await _preferences.setString(_keySavedPassword, savedPassword);

  static Future setPasscodeStatus(String passcodeStatus) async =>
      await _preferences.setString(_keyPasscodeStatus, passcodeStatus);

  // Get Agent Data
  static String? getEmail() => _preferences.getString(_keyEmail);

  static String? getFirstName() => _preferences.getString(_keyFirstName);

  static String? getLastName() => _preferences.getString(_keyLastName);

  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  static String? getId() => _preferences.getString(_keyId);

  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static String? getPhoneToken() => _preferences.getString(_keyPhoneToken);

  static String? getSavedPhoneNumber() =>
      _preferences.getString(_keySavedPhoneNumber);

  static String? getSavedPassword() =>
      _preferences.getString(_keySavedPassword);

  static String? getPasscodeStatus() =>
      _preferences.getString(_keyPasscodeStatus);

  // Clear Agent Token when logged out..
  static Future clearPhoneToken() async {
    await _preferences.remove(_keyPhoneToken);
  }

  // Clear Agent Saved login credentials
  static Future clearLoginCredentials() async {
    await _preferences.remove(_keySavedPhoneNumber);
    await _preferences.remove(_keySavedPassword);
  }
}
