// To parse this JSON data, do
//
//     final dataBundleModel = dataBundleModelFromJson(jsonString);

import 'dart:convert';

DataBundleModel dataBundleModelFromJson(String str) =>
    DataBundleModel.fromJson(json.decode(str));

String dataBundleModelToJson(DataBundleModel data) =>
    json.encode(data.toJson());

class DataBundleModel {
  String status;
  Map<String, Datum> data;

  DataBundleModel({
    required this.status,
    required this.data,
  });

  factory DataBundleModel.fromJson(Map<String, dynamic> json) =>
      DataBundleModel(
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
  int id;
  String billerCode;
  String name;
  double defaultCommission;
  DateTime dateAdded;
  String country;
  bool isAirtime;
  String billerName;
  String itemCode;
  String shortName;
  int fee;
  bool commissionOnFee;
  String labelName;
  int amount;

  Datum({
    required this.id,
    required this.billerCode,
    required this.name,
    required this.defaultCommission,
    required this.dateAdded,
    required this.country,
    required this.isAirtime,
    required this.billerName,
    required this.itemCode,
    required this.shortName,
    required this.fee,
    required this.commissionOnFee,
    required this.labelName,
    required this.amount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        billerCode: json["biller_code"],
        name: json["name"],
        defaultCommission: json["default_commission"]?.toDouble(),
        dateAdded: DateTime.parse(json["date_added"]),
        country: json["country"],
        isAirtime: json["is_airtime"],
        billerName: json["biller_name"],
        itemCode: json["item_code"],
        shortName: json["short_name"],
        fee: json["fee"],
        commissionOnFee: json["commission_on_fee"],
        labelName: json["label_name"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "biller_code": billerCode,
        "name": name,
        "default_commission": defaultCommission,
        "date_added": dateAdded.toIso8601String(),
        "country": country,
        "is_airtime": isAirtime,
        "biller_name": billerName,
        "item_code": itemCode,
        "short_name": shortName,
        "fee": fee,
        "commission_on_fee": commissionOnFee,
        "label_name": labelName,
        "amount": amount,
      };
}
