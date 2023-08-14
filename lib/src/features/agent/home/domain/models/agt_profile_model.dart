// To parse this JSON data, do
//
//     final agtProfileModel = agtProfileModelFromJson(jsonString);

import 'dart:convert';

AgtProfileModel agtProfileModelFromJson(String str) =>
    AgtProfileModel.fromJson(json.decode(str));

String agtProfileModelToJson(AgtProfileModel data) =>
    json.encode(data.toJson());

class AgtProfileModel {
  String status;
  String message;
  AgtProfileModelData data;

  AgtProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AgtProfileModel.fromJson(Map<String, dynamic> json) =>
      AgtProfileModel(
        status: json["status"],
        message: json["message"],
        data: AgtProfileModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class AgtProfileModelData {
  DataData data;

  AgtProfileModelData({
    required this.data,
  });

  factory AgtProfileModelData.fromJson(Map<String, dynamic> json) =>
      AgtProfileModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  IsDisabled isDisabled;
  String id;
  String name;
  String email;
  bool isBiometricRegistered;
  String walletId;
  int walletBalance;
  bool isVerified;
  String phoneNumber;
  String deviceId;
  String pin;
  String aggregatorId;
  String resetOtp;
  bool smssettings;
  DateTime walletCreatedDate;
  String bvn;
  String terminalId;
  String virtualAccountNumber;
  String viritualAccountName;
  String virtualCustomeCode;
  String virtualAccountId;
  String virtualBankName;
  int virtualAccountBalance;
  DateTime virtualAccountCreatedAt;
  bool rememberMe;
  DateTime createdAt;
  DateTime updatedAt;

  DataData({
    required this.isDisabled,
    required this.id,
    required this.name,
    required this.email,
    required this.isBiometricRegistered,
    required this.walletId,
    required this.walletBalance,
    required this.isVerified,
    required this.phoneNumber,
    required this.deviceId,
    required this.pin,
    required this.aggregatorId,
    required this.resetOtp,
    required this.smssettings,
    required this.walletCreatedDate,
    required this.bvn,
    required this.terminalId,
    required this.virtualAccountNumber,
    required this.viritualAccountName,
    required this.virtualCustomeCode,
    required this.virtualAccountId,
    required this.virtualBankName,
    required this.virtualAccountBalance,
    required this.virtualAccountCreatedAt,
    required this.rememberMe,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        isDisabled: IsDisabled.fromJson(json["isDisabled"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        isBiometricRegistered: json["isBiometricRegistered"],
        walletId: json["walletId"],
        walletBalance: json["walletBalance"],
        isVerified: json["isVerified"],
        phoneNumber: json["phoneNumber"],
        deviceId: json["deviceId"],
        pin: json["pin"],
        aggregatorId: json["aggregatorId"],
        resetOtp: json["resetOtp"],
        smssettings: json["smssettings"],
        walletCreatedDate: DateTime.parse(json["walletCreatedDate"]),
        bvn: json["bvn"],
        terminalId: json["terminalId"],
        virtualAccountNumber: json["virtualAccountNumber"],
        viritualAccountName: json["viritualAccountName"],
        virtualCustomeCode: json["virtualCustomeCode"],
        virtualAccountId: json["virtualAccountId"],
        virtualBankName: json["virtualBankName"],
        virtualAccountBalance: json["virtualAccountBalance"],
        virtualAccountCreatedAt:
            DateTime.parse(json["virtualAccountCreatedAt"]),
        rememberMe: json["rememberMe"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isDisabled": isDisabled.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "isBiometricRegistered": isBiometricRegistered,
        "walletId": walletId,
        "walletBalance": walletBalance,
        "isVerified": isVerified,
        "phoneNumber": phoneNumber,
        "deviceId": deviceId,
        "pin": pin,
        "aggregatorId": aggregatorId,
        "resetOtp": resetOtp,
        "smssettings": smssettings,
        "walletCreatedDate": walletCreatedDate.toIso8601String(),
        "bvn": bvn,
        "terminalId": terminalId,
        "virtualAccountNumber": virtualAccountNumber,
        "viritualAccountName": viritualAccountName,
        "virtualCustomeCode": virtualCustomeCode,
        "virtualAccountId": virtualAccountId,
        "virtualBankName": virtualBankName,
        "virtualAccountBalance": virtualAccountBalance,
        "virtualAccountCreatedAt": virtualAccountCreatedAt.toIso8601String(),
        "rememberMe": rememberMe,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class IsDisabled {
  bool disabled;
  String disabledBy;

  IsDisabled({
    required this.disabled,
    required this.disabledBy,
  });

  factory IsDisabled.fromJson(Map<String, dynamic> json) => IsDisabled(
        disabled: json["disabled"],
        disabledBy: json["disabledBy"],
      );

  Map<String, dynamic> toJson() => {
        "disabled": disabled,
        "disabledBy": disabledBy,
      };
}
