// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:yellowpage/utils/api_endpoints.dart';
// import 'package:http/http.dart' as http;

// class RegistrationController extends GetxController {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();

//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//   Future<void> registerWithEmail() async {
//     try {
//       var headers = {'content-type': 'application/json'};
//       var url = Uri.parse(
//           ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.registerEmail);
//       Map body = {
//         'name': nameController.text,
//         'email': emailController.text,
//         'password': passwordController.text,
//       };

//       http.Response response =
//           await http.post(url, body: jsonEncode(body), headers: headers);

//       if (response.statusCode == 200) {
//         final json = jsonDecode(response.body);
//         if (json['code'] == 0) {
//           var token = json['data']['token'];
//           print(token);
//           final SharedPreferences prefs = await _prefs;
//         }
//       }
//     } catch (e) {}
//   }
// }
