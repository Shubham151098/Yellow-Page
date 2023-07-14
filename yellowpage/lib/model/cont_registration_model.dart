// To parse this JSON data, do
//
//     final contRegistration = contRegistrationFromJson(jsonString);

import 'dart:convert';
// import 'package:http/http.dart' as http;

List<ContRegistration> contRegistrationFromJson(String str) => List<ContRegistration>.from(json.decode(str).map((x) => ContRegistration.fromJson(x)));

String contRegistrationToJson(ContRegistration data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class ContRegistration {
    int id;
    String name;
    String email;
    String contact;
    String alternateContact;
    String address;
    String image;
    String document;
    int city;
    int businessType;

    ContRegistration({
        required this.id,
        required this.name,
        required this.email,
        required this.contact,
        required this.alternateContact,
        required this.address,
        required this.image,
        required this.document,
        required this.city,
        required this.businessType,
    });

    factory ContRegistration.fromJson(Map<String, dynamic> json) => ContRegistration(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        contact: json["contact"],
        alternateContact: json["alternate_contact"],
        address: json["address"],
        image: json["image"],
        document: json["document"],
        city: json["city"],
        businessType: json["business_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "contact": contact,
        "alternate_contact": alternateContact,
        "address": address,
        "image": image,
        "document": document,
        "city": city,
        "business_type": businessType,
    };
}
