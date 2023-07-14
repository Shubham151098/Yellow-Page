// import 'package:flutter/material.dart';
// import 'package:yellowpage/controllers/api_controller.dart';
// import 'package:yellowpage/views/contact_page/members_page.dart';
// import '../../model/usermodel.dart';

// class ContactCategory extends StatefulWidget {
//   const ContactCategory({super.key});

//   @override
//   State<ContactCategory> createState() => _ContactCategoryState();
// }

// class _ContactCategoryState extends State<ContactCategory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         // automaticallyImplyLeading: false,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: const [
//                 Text(
//                   'Yellow',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontFamily: 'Raleway',
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Text(
//                   'Page',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontFamily: 'Raleway',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),

//             // Add Section
//             Container(
//               padding: const EdgeInsets.all(6),
//               decoration: const BoxDecoration(),
//               child: Row(
//                 children: const [
//                   Icon(Icons.phone),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text('Directory',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontFamily: 'Raleway',
//                         fontWeight: FontWeight.w500,
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: FutureBuilder<List<Fields>>(
//         future: ApiProvider().getUsers(),
//         builder: (context, snapshot) {
//           final data = snapshot.data;
//           if (snapshot.hasData) {
//             return Container(
//               color: Colors.white,
//               child: ListView.builder(
//                 itemCount: data!.length,
//                 itemBuilder: (context, index) {
//                   final fields = data[index];
//                   return Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.all(2),
//                         alignment: Alignment.center,
//                         height: 80,
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 0.2,
//                                 color: Colors.amber,
//                                 style: BorderStyle.solid)),
//                         child: ListTile(
//                           onTap: () {
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) =>
//                                     MembersPage(members: data[index].members),
//                               ),
//                             );
//                           },
//                           leading: Image.network(fields.fimage),
//                           title: Text(
//                             fields.fname,
//                             style: const TextStyle(
//                                 fontFamily: 'Raleway',
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             );
//           } else {
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/controllers/api_controller.dart';
// import 'package:yellowpage/model/cont_registration_model.dart';
import 'package:yellowpage/views/contact_page/members_page.dart';
import 'package:yellowpage/views/registration_screen.dart/cont_registration.dart';
// import 'package:yellowpage/widgets_common/contact_registration_form.dart';
import '../../model/usermodel.dart';
// import '../registration_screen.dart/contact_registration.dart';

class ContactCategory extends StatefulWidget {
  const ContactCategory({super.key});

  @override
  State<ContactCategory> createState() => _ContactCategoryState();
}

class _ContactCategoryState extends State<ContactCategory> {
  SharedPreferences? _prefs;
  bool _isLoading = true;
  List<Fields>? _data;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = false;
      _data = _getDataFromPrefs();
    });
  }

  List<Fields>? _getDataFromPrefs() {
    final jsonString = _prefs!.getString('fields');
    if (jsonString == null) {
      return null;
    }
    final List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => Fields.fromJson(e)).toList();
  }

  void _saveDataToPrefs(List<Fields> data) {
    final jsonString = jsonEncode(data);
    _prefs!.setString('fields', jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Text(
                  'Yellow',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Page',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.amber[300], shape: BoxShape.circle),
              child: const Icon(Icons.add),
            ).onTap(() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContRegistrationForm()));
            }),
          ],
        ),
      ),
      body: _isLoading
          ? const CircularProgressIndicator()
          : FutureBuilder<List<Fields>>(
              future: ApiProvider().getUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _data = snapshot.data;
                  _saveDataToPrefs(_data!); // Save data to SharedPreferences
                  return Container(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: _data!.length,
                      itemBuilder: (context, index) {
                        final fields = _data![index];
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              height: 80,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.2,
                                      color: Colors.amber,
                                      style: BorderStyle.solid)),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MembersPage(
                                        members: fields.members,
                                      ),
                                    ),
                                  );
                                },
                                leading: Image.network(fields.fimage),
                                title: Text(
                                  fields.fname,
                                  style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
    );
  }
}
