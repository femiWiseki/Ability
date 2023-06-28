// To parse this JSON data, do
//
//     final resolveAccNumModel = resolveAccNumModelFromJson(jsonString);

import 'dart:convert';

ResolveAccNumModel resolveAccNumModelFromJson(String str) =>
    ResolveAccNumModel.fromJson(json.decode(str));

String resolveAccNumModelToJson(ResolveAccNumModel data) =>
    json.encode(data.toJson());

class ResolveAccNumModel {
  String status;
  String message;
  ResolveAccNumModelData data;

  ResolveAccNumModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResolveAccNumModel.fromJson(Map<String, dynamic> json) =>
      ResolveAccNumModel(
        status: json["status"],
        message: json["message"],
        data: ResolveAccNumModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ResolveAccNumModelData {
  DataData data;

  ResolveAccNumModelData({
    required this.data,
  });

  factory ResolveAccNumModelData.fromJson(Map<String, dynamic> json) =>
      ResolveAccNumModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DataData {
  String accountNumber;
  String accountName;
  int bankId;

  DataData({
    required this.accountNumber,
    required this.accountName,
    required this.bankId,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        accountNumber: json["account_number"],
        accountName: json["account_name"],
        bankId: json["bank_id"],
      );

  Map<String, dynamic> toJson() => {
        "account_number": accountNumber,
        "account_name": accountName,
        "bank_id": bankId,
      };
}
