// To parse this JSON data, do
//
//     final banksDetailsModel = banksDetailsModelFromJson(jsonString);

import 'dart:convert';

BanksDetailsModel banksDetailsModelFromJson(String str) =>
    BanksDetailsModel.fromJson(json.decode(str));

String banksDetailsModelToJson(BanksDetailsModel data) =>
    json.encode(data.toJson());

class BanksDetailsModel {
  String message;
  List<Bank> banks;

  BanksDetailsModel({
    required this.message,
    required this.banks,
  });

  factory BanksDetailsModel.fromJson(Map<String, dynamic> json) =>
      BanksDetailsModel(
        message: json["message"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
      };
}

class Bank {
  int id;
  String name;
  String slug;
  String code;
  String longcode;
  dynamic gateway;
  bool payWithBank;
  bool active;
  Country country;
  Currency currency;
  Type type;
  bool isDeleted;
  DateTime? createdAt;
  DateTime updatedAt;
  String logo;

  Bank({
    required this.id,
    required this.name,
    required this.slug,
    required this.code,
    required this.longcode,
    required this.gateway,
    required this.payWithBank,
    required this.active,
    required this.country,
    required this.currency,
    required this.type,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.logo,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        code: json["code"],
        longcode: json["longcode"],
        gateway: json["gateway"],
        payWithBank: json["pay_with_bank"],
        active: json["active"],
        country: countryValues.map[json["country"]]!,
        currency: currencyValues.map[json["currency"]]!,
        type: typeValues.map[json["type"]]!,
        isDeleted: json["is_deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "code": code,
        "longcode": longcode,
        "gateway": [gateway],
        "pay_with_bank": payWithBank,
        "active": active,
        "country": countryValues.reverse[country],
        "currency": currencyValues.reverse[currency],
        "type": typeValues.reverse[type],
        "is_deleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "logo": logo,
      };
}

enum Country { NIGERIA }

final countryValues = EnumValues({"Nigeria": Country.NIGERIA});

enum Currency { NGN, USD }

final currencyValues = EnumValues({"NGN": Currency.NGN, "USD": Currency.USD});

enum Gateway { DIGITALBANKMANDATE, EMANDATE, EMPTY, IBANK }

// final gatewayValues = EnumValues({
//   "digitalbankmandate": Gateway.DIGITALBANKMANDATE,
//   "emandate": Gateway.EMANDATE,
//   "": Gateway.EMPTY,
//   "ibank": Gateway.IBANK
// });

enum Type { NUBAN }

final typeValues = EnumValues({"nuban": Type.NUBAN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
