// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:velocity_x/velocity_x.dart';
// import 'package:yellowpage/consts/colors.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';
// // import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// import '../homeScreen/home.dart';

// class EventRegistrationForm extends StatefulWidget {
//   const EventRegistrationForm({Key? key}) : super(key: key);

//   @override
//   State<EventRegistrationForm> createState() => _EventRegistrationFormState();
// }

// class _EventRegistrationFormState extends State<EventRegistrationForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   List<EventCategory> _eventCategory = [];
//   String _selectedEvents = "";
//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;

//   @override
//   void initState() {
//     super.initState();
//     fetchEventCategory();
//   }

//   Future<void> _showDatePicker() async {
//     final DateTime? pickedDate = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2100));

//     if (pickedDate != null && pickedDate != _selectedDate) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }

//   Future<void> _showTimePicker() async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (pickedTime != null && pickedTime != _selectedTime) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }

//   Future<void> fetchEventCategory() async {
//     final response = await http
//         .get(Uri.parse('http://127.0.0.1:8000/api/eventcategorydetails'));
//     print(response.body);
//     if (response.statusCode == 200) {
//       final jsonData = jsonDecode(response.body);
//       setState(() {
//         _eventCategory = jsonData
//             .map<EventCategory>((item) => EventCategory.fromJson(item))
//             .toList();
//         print(jsonData);
//       });
//     } else {
//       // Handle error
//       print('Failed to fetch events category');
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // ignore: unused_local_variable
//       final formData = _formKey.currentState!.save();
//       // Perform your form submission or API call here
//       // print(formData);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => const Home())),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: const [
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   'Yellow',
//                   style: TextStyle(
//                       fontSize: 26,
//                       fontFamily: 'Raleway',
//                       fontWeight: FontWeight.w700),
//                 ),
//                 Text(
//                   'Page',
//                   style: TextStyle(
//                       fontSize: 26,
//                       fontFamily: 'Raleway',
//                       fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//           width: context.screenWidth,
//           height: context.screenHeight,
//           color: lightGrey,
//           child: SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(115, 226, 226, 226),
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: Container(
//                       color: Colors.white,
//                       child: SingleChildScrollView(
//                         child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Event Name',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Name is required';
//                                       }
//                                       return null;
//                                     },
//                                     onSaved: (value) {},
//                                   ),
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Organiser Name',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     keyboardType: TextInputType.emailAddress,
//                                   ),
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Contact details',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     keyboardType: TextInputType.phone,
//                                   ),
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Address',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     maxLines: 3,
//                                   ),
//                                   InkWell(
//                                     onTap: _showDatePicker,
//                                     child: InputDecorator(
//                                       decoration: const InputDecoration(
//                                         labelStyle:
//                                             TextStyle(color: Colors.black),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             _selectedDate != null
//                                                 ? DateFormat('MMM dd, yyyy')
//                                                     .format(_selectedDate!)
//                                                 : 'Select Date',
//                                           ),
//                                           const Icon(
//                                             Icons.calendar_today,
//                                             color: Colors.blue,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: _showTimePicker,
//                                     child: InputDecorator(
//                                       decoration: const InputDecoration(
//                                         labelStyle:
//                                             TextStyle(color: Colors.black),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             _selectedTime != null
//                                                 ? _selectedTime!.format(context)
//                                                 : 'Select Time',
//                                           ),
//                                           const Icon(
//                                             Icons.access_time,
//                                             color: Colors.blue,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Description',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     maxLines: 3,
//                                   ),
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Booking Link',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     maxLines: 1,
//                                   ),
//                                   TextFormField(
//                                     decoration: const InputDecoration(
//                                       labelText: 'Google Map Location',
//                                       labelStyle:
//                                           TextStyle(color: Colors.black),
//                                     ),
//                                     maxLines: 1,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     width: double.infinity,
//                                     decoration:
//                                         const BoxDecoration(color: Colors.cyan),
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 5,
//                                     ),
//                                     child: const Text(
//                                       'Event Category',
//                                       style: TextStyle(
//                                           fontSize: 18, fontFamily: 'Raleway'),
//                                       textAlign: TextAlign.start,
//                                     ),
//                                   ),
//                                   Column(
//                                     children: _eventCategory.map((category) {
//                                       return RadioListTile<String>(
//                                         title: Text(category.eventCategory),
//                                         value: category.eventCategory,
//                                         groupValue: _selectedEvents,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             _selectedEvents = value!;
//                                           });
//                                         },
//                                       );
//                                     }).toList(),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: _submitForm,
//                                     style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.blue),
//                                     child: const Text('Submit'),
//                                   )
//                                 ],
//                               ),
//                             )),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }

// class EventCategory {
//   final String eventCategory;

//   EventCategory({required this.eventCategory});

//   factory EventCategory.fromJson(Map<String, dynamic> json) {
//     final eventCategory =
//         json['event_category'] != null ? json['event_category'] as String : '';
//     print(eventCategory);
//     return EventCategory(eventCategory: eventCategory);
//   }
// }
