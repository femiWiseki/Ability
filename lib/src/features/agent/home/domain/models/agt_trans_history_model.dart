// To parse this JSON data, do
//
//     final agtTransHIstoryModel = agtTransHIstoryModelFromJson(jsonString);

import 'dart:convert';

AgtTransHIstoryModel agtTransHIstoryModelFromJson(String str) =>
    AgtTransHIstoryModel.fromJson(json.decode(str));

String agtTransHIstoryModelToJson(AgtTransHIstoryModel data) =>
    json.encode(data.toJson());

class AgtTransHIstoryModel {
  String status;
  Data data;

  AgtTransHIstoryModel({
    required this.status,
    required this.data,
  });

  factory AgtTransHIstoryModel.fromJson(Map<String, dynamic> json) =>
      AgtTransHIstoryModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  int total;
  Pagination pagination;
  List<TransactionHistory> transactionHistory;

  Data({
    required this.total,
    required this.pagination,
    required this.transactionHistory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        pagination: Pagination.fromJson(json["pagination"]),
        transactionHistory: List<TransactionHistory>.from(
            json["transactionHistory"]
                .map((x) => TransactionHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "pagination": pagination.toJson(),
        "transactionHistory":
            List<dynamic>.from(transactionHistory.map((x) => x.toJson())),
      };
}

class Pagination {
  Pagination();

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination();

  Map<String, dynamic> toJson() => {};
}

class TransactionHistory {
  String id;
  String agentId;
  String transactionStatus;
  String transactionReference;
  String transactionType;
  String transactionAmount;
  DateTime transactionDate;
  String transactionDescription;
  dynamic transactionFailureReason;
  String transactionId;
  String transactionRecipient;
  String transactionTransferCode;
  dynamic transactionSourceDetails;
  String recipientBank;
  String recipientAccountName;
  String recipientAccountNumber;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  TransactionHistory({
    required this.id,
    required this.agentId,
    required this.transactionStatus,
    required this.transactionReference,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionDate,
    required this.transactionDescription,
    this.transactionFailureReason,
    required this.transactionId,
    required this.transactionRecipient,
    required this.transactionTransferCode,
    this.transactionSourceDetails,
    required this.recipientBank,
    required this.recipientAccountName,
    required this.recipientAccountNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        id: json["_id"],
        agentId: json["agentId"],
        transactionStatus: json["transactionStatus"],
        transactionReference: json["transactionReference"],
        transactionType: json["transactionType"],
        transactionAmount: json["transactionAmount"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        transactionDescription: json["transactionDescription"],
        transactionFailureReason: json["transactionFailureReason"],
        transactionId: json["transactionId"],
        transactionRecipient: json["transactionRecipient"],
        transactionTransferCode: json["transactionTransferCode"],
        transactionSourceDetails: json["transactionSourceDetails"],
        recipientBank: json["recipientBank"],
        recipientAccountName: json["recipientAccountName"],
        recipientAccountNumber: json["recipientAccountNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "agentId": agentId,
        "transactionStatus": transactionStatus,
        "transactionReference": transactionReference,
        "transactionType": transactionType,
        "transactionAmount": transactionAmount,
        "transactionDate": transactionDate.toIso8601String(),
        "transactionDescription": transactionDescription,
        "transactionFailureReason": transactionFailureReason,
        "transactionId": transactionId,
        "transactionRecipient": transactionRecipient,
        "transactionTransferCode": transactionTransferCode,
        "transactionSourceDetails": transactionSourceDetails,
        "recipientBank": recipientBank,
        "recipientAccountName": recipientAccountName,
        "recipientAccountNumber": recipientAccountNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
