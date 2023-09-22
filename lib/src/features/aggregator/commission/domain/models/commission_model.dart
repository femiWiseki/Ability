// To parse this JSON data, do
//
//     final commissionModel = commissionModelFromJson(jsonString);

import 'dart:convert';

CommissionModel commissionModelFromJson(String str) =>
    CommissionModel.fromJson(json.decode(str));

String commissionModelToJson(CommissionModel data) =>
    json.encode(data.toJson());

class CommissionModel {
  String status;
  String message;
  Data data;

  CommissionModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) =>
      CommissionModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  double totalCommision;
  List<Commission> commission;

  Data({
    required this.totalCommision,
    required this.commission,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCommision: json["total_commision"]?.toDouble(),
        commission: List<Commission>.from(
            json["commission"].map((x) => Commission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_commision": totalCommision,
        "commission": List<dynamic>.from(commission.map((x) => x.toJson())),
      };
}

class Commission {
  String id;
  String aggregatorId;
  String agentId;
  double amount;
  String commissionType;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Commission({
    required this.id,
    required this.aggregatorId,
    required this.agentId,
    required this.amount,
    required this.commissionType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
        id: json["_id"],
        aggregatorId: json["aggregatorId"],
        agentId: json["agentId"],
        amount: json["amount"]?.toDouble(),
        commissionType: json["commissionType"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "aggregatorId": aggregatorId,
        "agentId": agentId,
        "amount": amount,
        "commissionType": commissionType,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
