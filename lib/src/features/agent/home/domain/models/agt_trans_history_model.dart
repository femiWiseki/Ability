// To parse this JSON data, do
//
//     final agtTransHIstoryModel = agtTransHIstoryModelFromJson(jsonString);

import 'dart:convert';

AgtTransHIstoryModel agtTransHIstoryModelFromJson(String str) =>
    AgtTransHIstoryModel.fromJson(json.decode(str));

String agtTransHIstoryModelToJson(AgtTransHIstoryModel data) =>
    json.encode(data.toJson());

class AgtTransHIstoryModel {
  Status status;
  Data data;

  AgtTransHIstoryModel({
    required this.status,
    required this.data,
  });

  factory AgtTransHIstoryModel.fromJson(Map<String, dynamic> json) =>
      AgtTransHIstoryModel(
        status: statusValues.map[json["status"]]!,
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": statusValues.reverse[status],
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
  Next next;

  Pagination({
    required this.next,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        next: Next.fromJson(json["next"]),
      );

  Map<String, dynamic> toJson() => {
        "next": next.toJson(),
      };
}

class Next {
  int page;
  int limit;

  Next({
    required this.page,
    required this.limit,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        page: json["page"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
      };
}

class TransactionHistory {
  String id;
  AgentId agentId;
  Status transactionStatus;
  String transactionType;
  String transactionAmount;
  dynamic transactionDate;
  String transactionId;
  String transactionRecipient;
  String recipientBank;
  String recipientAccountName;
  String recipientAccountNumber;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String? transactionReference;
  String? transactionDescription;
  dynamic transactionFailureReason;
  String? transactionTransferCode;
  dynamic transactionSourceDetails;

  TransactionHistory({
    required this.id,
    required this.agentId,
    required this.transactionStatus,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionDate,
    required this.transactionId,
    required this.transactionRecipient,
    required this.recipientBank,
    required this.recipientAccountName,
    required this.recipientAccountNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.transactionReference,
    this.transactionDescription,
    this.transactionFailureReason,
    this.transactionTransferCode,
    this.transactionSourceDetails,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        id: json["_id"],
        agentId: agentIdValues.map[json["agentId"]]!,
        transactionStatus: statusValues.map[json["transactionStatus"]]!,
        transactionType: json["transactionType"],
        transactionAmount: json["transactionAmount"],
        transactionDate: json["transactionDate"],
        transactionId: json["transactionId"],
        transactionRecipient: json["transactionRecipient"],
        recipientBank: json["recipientBank"],
        recipientAccountName: json["recipientAccountName"],
        recipientAccountNumber: json["recipientAccountNumber"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        transactionReference: json["transactionReference"],
        transactionDescription: json["transactionDescription"],
        transactionFailureReason: json["transactionFailureReason"],
        transactionTransferCode: json["transactionTransferCode"],
        transactionSourceDetails: json["transactionSourceDetails"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "agentId": agentIdValues.reverse[agentId],
        "transactionStatus": statusValues.reverse[transactionStatus],
        "transactionType": transactionType,
        "transactionAmount": transactionAmount,
        "transactionDate": transactionDate,
        "transactionId": transactionId,
        "transactionRecipient": transactionRecipient,
        "recipientBank": recipientBank,
        "recipientAccountName": recipientAccountName,
        "recipientAccountNumber": recipientAccountNumber,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "transactionReference": transactionReference,
        "transactionDescription": transactionDescription,
        "transactionFailureReason": transactionFailureReason,
        "transactionTransferCode": transactionTransferCode,
        "transactionSourceDetails": transactionSourceDetails,
      };
}

enum AgentId { THE_64_CBF141_DAD }

final agentIdValues = EnumValues({"64cbf141dad": AgentId.THE_64_CBF141_DAD});

enum Status { PENDING, SUCCESS }

final statusValues =
    EnumValues({"pending": Status.PENDING, "success": Status.SUCCESS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
