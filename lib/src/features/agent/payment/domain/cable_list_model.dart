// To parse this JSON data, do
//
//     final cableListModel = cableListModelFromJson(jsonString);

import 'dart:convert';

CableListModel cableListModelFromJson(String str) =>
    CableListModel.fromJson(json.decode(str));

String cableListModelToJson(CableListModel data) => json.encode(data.toJson());

class CableListModel {
  String status;
  String message;
  Data data;

  CableListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CableListModel.fromJson(Map<String, dynamic> json) => CableListModel(
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
  String status;
  List<Datum> data;

  Data({
    required this.status,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  BillerCode billerCode;
  String name;
  double defaultCommission;
  DateTime dateAdded;
  Country country;
  bool isAirtime;
  String billerName;
  String itemCode;
  String shortName;
  int fee;
  bool commissionOnFee;
  LabelName labelName;
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
        billerCode: billerCodeValues.map[json["biller_code"]]!,
        name: json["name"],
        defaultCommission: json["default_commission"]?.toDouble(),
        dateAdded: DateTime.parse(json["date_added"]),
        country: countryValues.map[json["country"]]!,
        isAirtime: json["is_airtime"],
        billerName: json["biller_name"],
        itemCode: json["item_code"],
        shortName: json["short_name"],
        fee: json["fee"],
        commissionOnFee: json["commission_on_fee"],
        labelName: labelNameValues.map[json["label_name"]]!,
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "biller_code": billerCodeValues.reverse[billerCode],
        "name": name,
        "default_commission": defaultCommission,
        "date_added": dateAdded.toIso8601String(),
        "country": countryValues.reverse[country],
        "is_airtime": isAirtime,
        "biller_name": billerName,
        "item_code": itemCode,
        "short_name": shortName,
        "fee": fee,
        "commission_on_fee": commissionOnFee,
        "label_name": labelNameValues.reverse[labelName],
        "amount": amount,
      };
}

enum BillerCode { BIL121, BIL122, BIL123 }

final billerCodeValues = EnumValues({
  "BIL121": BillerCode.BIL121,
  "BIL122": BillerCode.BIL122,
  "BIL123": BillerCode.BIL123
});

enum Country { NG }

final countryValues = EnumValues({"NG": Country.NG});

enum LabelName { SMARTCARD_NUMBER, SMART_CARD_NUMBER }

final labelNameValues = EnumValues({
  "Smartcard Number": LabelName.SMARTCARD_NUMBER,
  "SmartCard Number": LabelName.SMART_CARD_NUMBER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
