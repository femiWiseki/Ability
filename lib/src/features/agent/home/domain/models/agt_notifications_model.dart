// To parse this JSON data, do
//
//     final agtNotificationsModel = agtNotificationsModelFromJson(jsonString);

import 'dart:convert';

AgtNotificationsModel agtNotificationsModelFromJson(String str) =>
    AgtNotificationsModel.fromJson(json.decode(str));

String agtNotificationsModelToJson(AgtNotificationsModel data) =>
    json.encode(data.toJson());

class AgtNotificationsModel {
  String status;
  Data data;

  AgtNotificationsModel({
    required this.status,
    required this.data,
  });

  factory AgtNotificationsModel.fromJson(Map<String, dynamic> json) =>
      AgtNotificationsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<Notification> notification;

  Data({
    required this.notification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notification: List<Notification>.from(
            json["notification"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notification": List<dynamic>.from(notification.map((x) => x.toJson())),
      };
}

class Notification {
  String id;
  String title;
  String body;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic v;

  Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "body": body,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
