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
  String transactionType;
  String? recipientBank;
  String recipientAccountName;
  String? recipientAccountNumber;
  String? ref;
  String? type;
  String? source;
  String transactionGroup;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String transactionAmount;
  dynamic transactionDate;
  String? transactionDescription;
  dynamic transactionFailureReason;
  String? transactionId;
  String? transactionRecipient;
  String? transactionReference;
  dynamic transactionSourceDetails;
  String? transactionTransferCode;
  String sessionId;
  String? transactionCurrency;

  TransactionHistory({
    required this.id,
    required this.agentId,
    required this.transactionStatus,
    required this.transactionType,
    this.recipientBank,
    required this.recipientAccountName,
    this.recipientAccountNumber,
    this.ref,
    this.type,
    this.source,
    required this.transactionGroup,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.transactionAmount,
    required this.transactionDate,
    this.transactionDescription,
    this.transactionFailureReason,
    this.transactionId,
    this.transactionRecipient,
    this.transactionReference,
    this.transactionSourceDetails,
    this.transactionTransferCode,
    required this.sessionId,
    this.transactionCurrency,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        id: json["_id"],
        agentId: json["agentId"],
        transactionStatus: json["transactionStatus"],
        transactionType: json["transactionType"],
        recipientBank: json["recipientBank"],
        recipientAccountName: json["recipientAccountName"],
        recipientAccountNumber: json["recipientAccountNumber"],
        ref: json["ref"],
        type: json["type"],
        source: json["source"],
        transactionGroup: json["transactionGroup"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        transactionAmount: json["transactionAmount"],
        transactionDate: json["transactionDate"],
        transactionDescription: json["transactionDescription"],
        transactionFailureReason: json["transactionFailureReason"],
        transactionId: json["transactionId"],
        transactionRecipient: json["transactionRecipient"],
        transactionReference: json["transactionReference"],
        transactionSourceDetails: json["transactionSourceDetails"],
        transactionTransferCode: json["transactionTransferCode"],
        sessionId: json["sessionId"],
        transactionCurrency: json["transactionCurrency"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "agentId": agentId,
        "transactionStatus": transactionStatus,
        "transactionType": transactionType,
        "recipientBank": recipientBank,
        "recipientAccountName": recipientAccountName,
        "recipientAccountNumber": recipientAccountNumber,
        "ref": ref,
        "type": type,
        "source": source,
        "transactionGroup": transactionGroup,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "transactionAmount": transactionAmount,
        "transactionDate": transactionDate,
        "transactionDescription": transactionDescription,
        "transactionFailureReason": transactionFailureReason,
        "transactionId": transactionId,
        "transactionRecipient": transactionRecipient,
        "transactionReference": transactionReference,
        "transactionSourceDetails": transactionSourceDetails,
        "transactionTransferCode": transactionTransferCode,
        "sessionId": sessionId,
        "transactionCurrency": transactionCurrency,
      };
}
