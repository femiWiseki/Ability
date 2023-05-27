import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static late SharedPreferences _preferences;

  static const _keyEmail = 'email';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';
  static const _keyPhoneNumber = 'phoneNumber';
  static const _keyDialingCode = 'dailingCode';
  static const _keyId = 'id';
  static const _keySavePhoneNumber = 'savePhoneNumber';
  static const _keySavePassword = 'savePassword';
  static const _keySavingsName = 'savingsName';
  static const _keyFrequency = 'frequency';
  static const _keyStartDate = 'startDate';
  static const _keyMaturityDate = 'maturityDate';
  static const _keyVirtualAccount = 'virtualAccount';

  // Token Keys
  static const _keyAccessToken = 'accessToken';
  static const _keyPhoneToken = 'phoneToken';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  /// Save users data when they are logged in.. and to save user state
  static Future setEmail(String email) async =>
      await _preferences.setString(_keyEmail, email);

  static Future setFirstName(String firstname) async =>
      await _preferences.setString(_keyFirstName, firstname);

  static Future setLastName(String lastname) async =>
      await _preferences.setString(_keyLastName, lastname);

  static Future setPhoneNumber(String phoneNumber) async =>
      await _preferences.setString(_keyPhoneNumber, phoneNumber);

  static Future setDialingCode(String dailingCode) async =>
      await _preferences.setString(_keyDialingCode, dailingCode);

  static Future setId(String id) async =>
      await _preferences.setString(_keyId, id);

  static Future setSavePhoneNumber(String savePhoneNumber) async =>
      await _preferences.setString(_keySavePhoneNumber, savePhoneNumber);

  static Future setSavePassword(String savePassword) async =>
      await _preferences.setString(_keySavePassword, savePassword);

  static Future setUserVirtualAccount(String virtualAccount) async =>
      await _preferences.setString(_keyVirtualAccount, virtualAccount);

  static Future setSavingsName(String savingsName) async =>
      await _preferences.setString(_keySavingsName, savingsName);

  static Future setFrequency(String frequency) async =>
      await _preferences.setString(_keyFrequency, frequency);

  static Future setStartDate(String startDate) async =>
      await _preferences.setString(_keyStartDate, startDate);

  static Future setMaturityDate(String maturityDate) async =>
      await _preferences.setString(_keyMaturityDate, maturityDate);

  // Set Tokens
  static Future setAccessToken(String accessToken) async =>
      await _preferences.setString(_keyAccessToken, accessToken);

  static Future setPhoneToken(String phoneToken) async =>
      await _preferences.setString(_keyPhoneToken, phoneToken);

  /// Get users data when they are logged in..
  static String? getEmail() => _preferences.getString(_keyEmail);

  static String? getFirstName() => _preferences.getString(_keyFirstName);

  static String? getLastName() => _preferences.getString(_keyLastName);

  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  static String? getDialingCode() => _preferences.getString(_keyDialingCode);

  static String? getId() => _preferences.getString(_keyId);

  static String? getSavePhoneNumber() =>
      _preferences.getString(_keySavePhoneNumber);

  static String? getSavePassword() => _preferences.getString(_keySavePassword);

  static String? getUserVirtualAccount() =>
      _preferences.getString(_keyVirtualAccount);

  static String? getSavingsName() => _preferences.getString(_keySavingsName);

  static String? getFrequency() => _preferences.getString(_keyFrequency);

  static String? getStartDate() => _preferences.getString(_keyStartDate);

  static String? getMaturityDate() => _preferences.getString(_keyMaturityDate);

  // Get Tokens
  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static String? getPhoneToken() => _preferences.getString(_keyPhoneToken);

  /// Clear users Access Token when they log out..
  static Future clearAccessToken() async {
    await _preferences.remove(_keyAccessToken);
  }
}
