// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:yellowpage/model/contact_registration.dart';

// class ContactRegistrationForm extends StatefulWidget {
//   const ContactRegistrationForm({Key? key}) : super(key: key);

//   @override
//   _ContactRegistrationFormState createState() =>
//       _ContactRegistrationFormState();
// }

// class _ContactRegistrationFormState extends State<ContactRegistrationForm> {
//   final _formKey = GlobalKey<FormState>();
//   late ContactRegistration _contactRegistration;
//   late Rcity _selectedCity;
//   List<Rcity> _cities = [];

//   @override
//   void initState() {
//     super.initState();
//     _contactRegistration = ContactRegistration(
//       id: 0,
//       rname: '',
//       remail: '',
//       rcontacts: '',
//       rcontactsAlternate: '',
//       raddress: '',
//       rcity: Rcity(id: 0, cityName: ''), // Set default city
//       businessType: 0,
//       rimage: '',
//       rdocument: '',
//     );
//     _selectedCity = _contactRegistration.rcity; // Initialize _selectedCity
//     fetchCities();
//   }

//   void fetchCities() async {
//     final response =
//         await http.get(Uri.parse('http://127.0.0.1:8000/api/citynamedetails'));
//     if (response.statusCode == 200) {
//       List<dynamic> citiesJson = json.decode(response.body);
//       List<Rcity> cities =
//           citiesJson.map((cityJson) => Rcity.fromJson(cityJson)).toList();

//       setState(() {
//         _cities = cities;
//       });
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Form is valid, perform desired actions
//       _formKey.currentState!.save();
//
//       print('Submitted: ${_contactRegistration.toJson()}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact Registration Form'),
//       ),
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter a name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _contactRegistration.rname = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _contactRegistration.remail = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Contacts'),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter contacts';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _contactRegistration.rcontacts = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Alternate Contacts'),
//                 onSaved: (value) {
//                   _contactRegistration.rcontactsAlternate = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Address'),
//                 onSaved: (value) {
//                   _contactRegistration.raddress = value!;
//                 },
//               ),
//               DropdownButtonFormField<Rcity>(
//                 decoration: InputDecoration(labelText: 'City'),
//                 value: _selectedCity,
//                 items: _cities.map((city) {
//                   return DropdownMenuItem<Rcity>(
//                     value: city,
//                     child: Text(city.cityName),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedCity = value!;
//                     _contactRegistration.rcity = _selectedCity;
//                   });
//                 },
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please select a city';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Business Type'),
//                 keyboardType: TextInputType.number,
//                 onSaved: (value) {
//                   _contactRegistration.businessType = int.parse(value!);
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Image'),
//                 onSaved: (value) {
//                   _contactRegistration.rimage = value!;
//                 },
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Document'),
//                 onSaved: (value) {
//                   _contactRegistration.rdocument = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<CityName> _cityNames = [];
  String _selectedCity = '';

  @override
  void initState() {
    super.initState();
    fetchCityNames();
  }

  Future<void> fetchCityNames() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/citynamedetails'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _cityNames =
            jsonData.map<CityName>((item) => CityName.fromJson(item)).toList();
      });
    } else {
      // Handle error
      // print('Failed to fetch city names');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // final formData = _formKey.currentState!.save();
      // Perform your form submission or API call here
      // print(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        // Save the value
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Contacts'),
                      keyboardType: TextInputType.phone,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Alternate Contacts'),
                      keyboardType: TextInputType.phone,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Address'),
                      maxLines: 3,
                    ),
                    Column(
                      children: _cityNames.map((cityName) {
                        return RadioListTile<String>(
                          title: Text(cityName.cityName),
                          value: cityName.cityName,
                          groupValue: _selectedCity,
                          onChanged: (value) {
                            setState(() {
                              _selectedCity = value!;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Business Type'),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CityName {
  final String cityName;

  CityName({required this.cityName});

  factory CityName.fromJson(Map<String, dynamic> json) {
    return CityName(
      cityName: json['city_name'],
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: ContactForm(),
//   ));
// }
