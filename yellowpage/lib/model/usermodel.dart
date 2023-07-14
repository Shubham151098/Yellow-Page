// To parse this JSON data, do
//
//     final fields = fieldsFromJson(jsonString);

import 'dart:convert';

List<Fields> fieldsFromJson(String str) =>
    List<Fields>.from(json.decode(str).map((x) => Fields.fromJson(x)));

String fieldsToJson(List<Fields> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// for members

List<Member> membersFromJson(String str) =>
    List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));

String membersToJson(List<Member> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fields {
  Fields({
    required this.id,
    required this.members,
    required this.fname,
    required this.fimage,
  });

  int id;
  List<Member> members;
  String fname;
  String fimage;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        id: json["id"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        fname: json["fname"],
        fimage: json["fimage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "fname": fname,
        "fimage": fimage,
      };
}

class Member {
  Member({
    required this.id,
    required this.mname,
    required this.mnumber,
    required this.mfield,
    required this.maddress,
  });

  int id;
  String mname;
  int mnumber;
  int mfield;
  String maddress;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        mname: json["mname"],
        mnumber: json["mnumber"],
        mfield: json["mfield"],
        maddress: json["maddress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mname": mname,
        "mnumber": mnumber,
        "maddress": maddress,
        "mfield": mfield,
      };
}
