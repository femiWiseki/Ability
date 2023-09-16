// To parse this JSON data, do
//
//     final aggProfileModel = aggProfileModelFromJson(jsonString);

import 'dart:convert';

AggProfileModel aggProfileModelFromJson(String str) =>
    AggProfileModel.fromJson(json.decode(str));

String aggProfileModelToJson(AggProfileModel data) =>
    json.encode(data.toJson());

class AggProfileModel {
  String status;
  String message;
  AggProfileModelData data;

  AggProfileModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AggProfileModel.fromJson(Map<String, dynamic> json) =>
      AggProfileModel(
        status: json["status"],
        message: json["message"],
        data: AggProfileModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class AggProfileModelData {
  DataData data;

  AggProfileModelData({
    required this.data,
  });

  factory AggProfileModelData.fromJson(Map<String, dynamic> json) =>
      AggProfileModelData(
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
  String pin;
  String resetOtp;
  String email;
  String phoneNumber;
  String walletId;
  int walletBalance;
  bool isVerified;
  String priceSettings;
  double withdrawalCharges;
  DateTime walletCreatedDate;
  bool isApprovedByAdmin;
  DateTime createdAt;
  DateTime updatedAt;

  DataData({
    required this.isDisabled,
    required this.id,
    required this.name,
    required this.pin,
    required this.resetOtp,
    required this.email,
    required this.phoneNumber,
    required this.walletId,
    required this.walletBalance,
    required this.isVerified,
    required this.priceSettings,
    required this.withdrawalCharges,
    required this.walletCreatedDate,
    required this.isApprovedByAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        isDisabled: IsDisabled.fromJson(json["isDisabled"]),
        id: json["_id"],
        name: json["name"],
        pin: json["pin"],
        resetOtp: json["resetOtp"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        walletId: json["walletId"],
        walletBalance: json["walletBalance"],
        isVerified: json["isVerified"],
        priceSettings: json["priceSettings"],
        withdrawalCharges: json["withdrawalCharges"]?.toDouble(),
        walletCreatedDate: DateTime.parse(json["walletCreatedDate"]),
        isApprovedByAdmin: json["isApprovedByAdmin"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isDisabled": isDisabled.toJson(),
        "_id": id,
        "name": name,
        "pin": pin,
        "resetOtp": resetOtp,
        "email": email,
        "phoneNumber": phoneNumber,
        "walletId": walletId,
        "walletBalance": walletBalance,
        "isVerified": isVerified,
        "priceSettings": priceSettings,
        "withdrawalCharges": withdrawalCharges,
        "walletCreatedDate": walletCreatedDate.toIso8601String(),
        "isApprovedByAdmin": isApprovedByAdmin,
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
