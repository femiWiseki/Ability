// To parse this JSON data, do
//
//     final agtWithdrawalHistoryModel = agtWithdrawalHistoryModelFromJson(jsonString);

import 'dart:convert';

AgtWithdrawalHistoryModel agtWithdrawalHistoryModelFromJson(String str) =>
    AgtWithdrawalHistoryModel.fromJson(json.decode(str));

String agtWithdrawalHistoryModelToJson(AgtWithdrawalHistoryModel data) =>
    json.encode(data.toJson());

class AgtWithdrawalHistoryModel {
  String status;
  Data data;

  AgtWithdrawalHistoryModel({
    required this.status,
    required this.data,
  });

  factory AgtWithdrawalHistoryModel.fromJson(Map<String, dynamic> json) =>
      AgtWithdrawalHistoryModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<WithdrawalNotification> withdrawalNotifications;
  int totalRecords;
  int totalPages;
  int currentPage;

  Data({
    required this.withdrawalNotifications,
    required this.totalRecords,
    required this.totalPages,
    required this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        withdrawalNotifications: List<WithdrawalNotification>.from(
            json["withdrawalNotifications"]
                .map((x) => WithdrawalNotification.fromJson(x))),
        totalRecords: json["totalRecords"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
      );

  Map<String, dynamic> toJson() => {
        "withdrawalNotifications":
            List<dynamic>.from(withdrawalNotifications.map((x) => x.toJson())),
        "totalRecords": totalRecords,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class WithdrawalNotification {
  String id;
  String terminalId;
  String merchantId;
  String name;
  String pan;
  String amount;
  String description;
  String stan;
  String rrn;
  String responseDescription;
  String reference;
  String esp;
  DateTime created;
  String agentId;
  String respCode;
  String withdrawalStatus;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  WithdrawalNotification({
    required this.id,
    required this.terminalId,
    required this.merchantId,
    required this.name,
    required this.pan,
    required this.amount,
    required this.description,
    required this.stan,
    required this.rrn,
    required this.responseDescription,
    required this.reference,
    required this.esp,
    required this.created,
    required this.agentId,
    required this.respCode,
    required this.withdrawalStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory WithdrawalNotification.fromJson(Map<String, dynamic> json) =>
      WithdrawalNotification(
        id: json["_id"],
        terminalId: json["terminalId"],
        merchantId: json["merchantId"],
        name: json["name"],
        pan: json["pan"],
        amount: json["amount"],
        description: json["description"],
        stan: json["stan"],
        rrn: json["rrn"],
        responseDescription: json["responseDescription"],
        reference: json["reference"],
        esp: json["esp"],
        created: DateTime.parse(json["created"]),
        agentId: json["agentId"],
        respCode: json["respCode"],
        withdrawalStatus: json["withdrawalStatus"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "terminalId": terminalId,
        "merchantId": merchantId,
        "name": name,
        "pan": pan,
        "amount": amount,
        "description": description,
        "stan": stan,
        "rrn": rrn,
        "responseDescription": responseDescription,
        "reference": reference,
        "esp": esp,
        "created": created.toIso8601String(),
        "agentId": agentId,
        "respCode": respCode,
        "withdrawalStatus": withdrawalStatus,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
