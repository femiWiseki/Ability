import 'package:shared_preferences/shared_preferences.dart';

class AgentPreference {
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

  // Get Agent Data
  static String? getEmail() => _preferences.getString(_keyEmail);

  static String? getFirstName() => _preferences.getString(_keyFirstName);

  static String? getLastName() => _preferences.getString(_keyLastName);

  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  static String? getId() => _preferences.getString(_keyId);

  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static String? getSavedPhoneNumber() =>
      _preferences.getString(_keySavedPhoneNumber);

  static String? getSavedPassword() =>
      _preferences.getString(_keySavedPassword);

  /// Clear Agent Token when logged out..
  static Future clearAccessToken() async {
    await _preferences.remove(_keyAccessToken);
  }

  // Clear Agent Saved login credentials
  static Future clearLoginCredentials() async {
    await _preferences.remove(_keySavedPhoneNumber);
    await _preferences.remove(_keySavedPassword);
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

  // Get Agent Data
  static String? getEmail() => _preferences.getString(_keyEmail);

  static String? getFirstName() => _preferences.getString(_keyFirstName);

  static String? getLastName() => _preferences.getString(_keyLastName);

  static String? getPhoneNumber() => _preferences.getString(_keyPhoneNumber);

  static String? getId() => _preferences.getString(_keyId);

  static String? getAccessToken() => _preferences.getString(_keyAccessToken);

  static String? getSavedPhoneNumber() =>
      _preferences.getString(_keySavedPhoneNumber);

  static String? getSavedPassword() =>
      _preferences.getString(_keySavedPassword);

  // Clear Agent Token when logged out..
  static Future clearAccessToken() async {
    await _preferences.remove(_keyAccessToken);
  }

  // Clear Agent Saved login credentials
  static Future clearLoginCredentials() async {
    await _preferences.remove(_keySavedPhoneNumber);
    await _preferences.remove(_keySavedPassword);
  }
}
