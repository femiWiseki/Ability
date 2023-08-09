// To parse this JSON data, do
//
//     final agtTransferMoneyModel = agtTransferMoneyModelFromJson(jsonString);

import 'dart:convert';

AgtTransferMoneyModel agtTransferMoneyModelFromJson(String str) =>
    AgtTransferMoneyModel.fromJson(json.decode(str));

String agtTransferMoneyModelToJson(AgtTransferMoneyModel data) =>
    json.encode(data.toJson());

class AgtTransferMoneyModel {
  String status;
  Data data;

  AgtTransferMoneyModel({
    required this.status,
    required this.data,
  });

  factory AgtTransferMoneyModel.fromJson(Map<String, dynamic> json) =>
      AgtTransferMoneyModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  String narration;
  String transactionStatus;
  String transactionReference;
  DateTime transactionDate;
  dynamic transactionAmount;

  Data({
    required this.narration,
    required this.transactionStatus,
    required this.transactionReference,
    required this.transactionDate,
    required this.transactionAmount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        narration: json["narration"],
        transactionStatus: json["transactionStatus"],
        transactionReference: json["transactionReference"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        transactionAmount: json["transactionAmount"],
      );

  Map<String, dynamic> toJson() => {
        "narration": narration,
        "transactionStatus": transactionStatus,
        "transactionReference": transactionReference,
        "transactionDate": transactionDate.toIso8601String(),
        "transactionAmount": transactionAmount,
      };
}
