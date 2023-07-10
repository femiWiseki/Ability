// To parse this JSON data, do
//
//     final beneficiaryModel = beneficiaryModelFromJson(jsonString);

import 'dart:convert';

BeneficiaryModel beneficiaryModelFromJson(String str) =>
    BeneficiaryModel.fromJson(json.decode(str));

String beneficiaryModelToJson(BeneficiaryModel data) =>
    json.encode(data.toJson());

class BeneficiaryModel {
  String status;
  Map<String, Datum> data;

  BeneficiaryModel({
    required this.status,
    required this.data,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) =>
      BeneficiaryModel(
        status: json["status"],
        data: Map.from(json["data"])
            .map((k, v) => MapEntry<String, Datum>(k, Datum.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": Map.from(data)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Datum {
  String id;
  String accountNumber;
  String bankCode;
  String bankName;
  String accountName;
  String agentId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.accountNumber,
    required this.bankCode,
    required this.bankName,
    required this.accountName,
    required this.agentId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        accountNumber: json["accountNumber"],
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        accountName: json["accountName"],
        agentId: json["agentId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "accountNumber": accountNumber,
        "bankCode": bankCode,
        "bankName": bankName,
        "accountName": accountName,
        "agentId": agentId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
