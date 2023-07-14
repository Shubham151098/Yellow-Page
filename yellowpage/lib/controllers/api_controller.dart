import 'package:http/http.dart' as http;

import '../model/usermodel.dart';

class ApiProvider {
  Future<List<Fields>> getUsers() async {
    final req =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/fieldsdetails'));

    if (req.statusCode == 200) {
      final body = req.body;
      final fields = fieldsFromJson(body);
      // print(fields);
      return fields;
    } else {
      final body = req.body;
      final error = fieldsFromJson(body);
      // print(error);
      return error;
    }
  }
}

// import 'package:http/http.dart' as http;

// import '../model/usermodel.dart';

// class ApiProvider {
//   Future<List<Fields>> getUsers(List<String> ips) async {
//     ApiProvider apiProvider = ApiProvider();
//     List<String> ips = ['10.0.2.2', '127.0.0.1'];
//     List<Fields> fieldsList = await apiProvider.getUsers(ips);
//     // List<Fields> fieldsList = [];

//     for (String ip in ips) {
//       final req =
//           await http.get(Uri.parse('http://$ip:8000/api/fieldsdetails'));

//       if (req.statusCode == 200) {
//         final body = req.body;
//         final fields = fieldsFromJson(body);
//         fieldsList.addAll(fields);
//       } else {
//         final body = req.body;
//         final error = fieldsFromJson(body);
//         // handle error
//       }
//     }

//     return fieldsList;
//   }
// }
