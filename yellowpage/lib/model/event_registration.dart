// To parse this JSON data, do
//
//     final eventRegistration = eventRegistrationFromJson(jsonString);

import 'dart:convert';

List<EventRegistration> eventRegistrationFromJson(String str) => List<EventRegistration>.from(json.decode(str).map((x) => EventRegistration.fromJson(x)));

String eventRegistrationToJson(List<EventRegistration> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventRegistration {
    int id;
    String eventName;
    String eventOrganiser;
    String eventContact;
    String eventAddress;
    DateTime edate;
    String eventTime;
    String eventDesc;
    List<int>? eventImage;
    String bookingLink;
    String direction;
    int categoryType;

    EventRegistration({
        required this.id,
        required this.eventName,
        required this.eventOrganiser,
        required this.eventContact,
        required this.eventAddress,
        required this.edate,
        required this.eventTime,
        required this.eventDesc,
        this.eventImage,
        required this.bookingLink,
        required this.direction,
        required this.categoryType,
    });

    factory EventRegistration.fromJson(Map<String, dynamic> json) => EventRegistration(
        id: json["id"],
        eventName: json["event_name"],
        eventOrganiser: json["event_organiser"],
        eventContact: json["event_contact"],
        eventAddress: json["event_address"],
        edate: DateTime.parse(json["edate"]),
        eventTime: json["event_time"],
        eventDesc: json["event_desc"],
        eventImage: json["event_image"] != null ? List<int>.from(json["event_image"]) : null,
        bookingLink: json["booking_link"],
        direction: json["direction"],
        categoryType: json["category_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "event_name": eventName,
        "event_organiser": eventOrganiser,
        "event_contact": eventContact,
        "event_address": eventAddress,
        "edate": "${edate.year.toString().padLeft(4, '0')}-${edate.month.toString().padLeft(2, '0')}-${edate.day.toString().padLeft(2, '0')}",
        "event_time": eventTime,
        "event_desc": eventDesc,
        "event_image": eventImage,
        "booking_link": bookingLink,
        "direction": direction,
        "category_type": categoryType,
    };
}
