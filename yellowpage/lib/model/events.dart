// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

List<Events> eventsFromJson(String str) =>
    List<Events>.from(json.decode(str).map((x) => Events.fromJson(x)));

String eventsToJson(List<Events> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Events {
  String eventname;
  CategoryType categoryType;
  String organiserName;
  String eventContact;
  String eaddress;
  DateTime edate;
  String etime;
  String edesc;
  String eimage;
  String eimageUrl;
  String bookingLink;
  String direction;

  Events({
    required this.eventname,
    required this.categoryType,
    required this.organiserName,
    required this.eventContact,
    required this.eaddress,
    required this.edate,
    required this.etime,
    required this.edesc,
    required this.eimage,
    required this.eimageUrl,
    required this.bookingLink,
    required this.direction,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        eventname: json["eventname"] ?? "",
        categoryType: json["category_type"] != null
            ? CategoryType.fromJson(json["category_type"])
            : CategoryType(eventCategory: ""),
        organiserName: json["organiser_name"] ?? "",
        eventContact: json["event_contact"] ?? "",
        eaddress: json["eaddress"] ?? "",
        edate: DateTime.parse(json["edate"]),
        etime: json["etime"] ?? "",
        edesc: json["edesc"] ?? "",
        eimage: json["eimage"] ?? "",
        eimageUrl: json["eimage_url"] ?? "",
        bookingLink: json["booking_link"] ?? "",
        direction: json["direction"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "eventname": eventname,
        "category_type": categoryType.toJson(),
        "organiser_name": organiserName,
        "event_contact": eventContact,
        "eaddress": eaddress,
        "edate":
            "${edate.year.toString().padLeft(4, '0')}-${edate.month.toString().padLeft(2, '0')}-${edate.day.toString().padLeft(2, '0')}",
        "etime": etime,
        "edesc": edesc,
        "eimage": eimage,
        "eimage_url": eimageUrl,
        "booking_link": bookingLink,
        "direction": direction,
      };
}

class CategoryType {
  String eventCategory;

  CategoryType({
    required this.eventCategory,
  });

  factory CategoryType.fromJson(Map<String, dynamic> json) => CategoryType(
        eventCategory: json["event_category"],
      );

  Map<String, dynamic> toJson() => {
        "event_category": eventCategory,
      };
}
