// To parse this JSON data, do
//
//     final contactRegistration = contactRegistrationFromJson(jsonString);

import 'dart:convert';

List<ContactRegistration> contactRegistrationFromJson(String str) =>
    List<ContactRegistration>.from(
        json.decode(str).map((x) => ContactRegistration.fromJson(x)));

String contactRegistrationToJson(List<ContactRegistration> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactRegistration {
  int id;
  String rname;
  String remail;
  String rcontacts;
  String rcontactsAlternate;
  String raddress;
  Rcity rcity;
  int businessType;
  String rimage;
  String rdocument;

  ContactRegistration({
    required this.id,
    required this.rname,
    required this.remail,
    required this.rcontacts,
    required this.rcontactsAlternate,
    required this.raddress,
    required this.rcity,
    required this.businessType,
    required this.rimage,
    required this.rdocument,
  });

  factory ContactRegistration.fromJson(Map<String, dynamic> json) =>
      ContactRegistration(
        id: json["id"],
        rname: json["rname"],
        remail: json["remail"],
        rcontacts: json["rcontacts"],
        rcontactsAlternate: json["rcontacts_alternate"],
        raddress: json["raddress"],
        rcity: Rcity.fromJson(json["rcity"]),
        businessType: json["business_type"],
        rimage: json["rimage"],
        rdocument: json["rdocument"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rname": rname,
        "remail": remail,
        "rcontacts": rcontacts,
        "rcontacts_alternate": rcontactsAlternate,
        "raddress": raddress,
        "rcity": rcity.toJson(),
        "business_type": businessType,
        "rimage": rimage,
        "rdocument": rdocument,
      };
}

class Rcity {
  int id;
  String cityName;

  Rcity({
    required this.id,
    required this.cityName,
  });

  factory Rcity.fromJson(Map<String, dynamic> json) => Rcity(
        id: json["id"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_name": cityName,
      };
}
