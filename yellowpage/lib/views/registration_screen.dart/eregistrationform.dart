// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class EventRegistrationForm extends StatefulWidget {
  @override
  _EventRegistrationFormState createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventOrganiserController =
      TextEditingController();
  final TextEditingController eventContactController = TextEditingController();
  final TextEditingController eventAddressController = TextEditingController();
  final TextEditingController eventTimeController = TextEditingController();
  final TextEditingController eventDescController = TextEditingController();
  final TextEditingController eventImageController = TextEditingController();
  final TextEditingController bookingLinkController = TextEditingController();
  final TextEditingController directionController = TextEditingController();
  final TextEditingController categoryTypeController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  File? selectedImage;

  Future<void> registerEvent() async {
    final apiUrl = 'http://127.0.0.1:8000/register-event/';

    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['event_name'] = eventNameController.text;
    request.fields['event_organiser'] = eventOrganiserController.text;
    request.fields['event_contact'] = eventContactController.text;
    request.fields['event_address'] = eventAddressController.text;
    request.fields['edate'] = DateFormat('yyyy-MM-dd').format(selectedDate!);
    request.fields['event_time'] = selectedTime!.format(context);
    request.fields['event_desc'] = eventDescController.text;
    request.fields['booking_link'] = bookingLinkController.text;
    request.fields['direction'] = directionController.text;
    request.fields['category_type'] =
        categoryTypes.indexOf(selectedCategoryType).toString();

    if (selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'event_image',
        selectedImage!.path,
      ));
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text('Event registration successful.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // Registration successful
      // ...
    } else {
      final responseBody = await response.stream.bytesToString();
      print(responseBody);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text('Event registration failed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      // Registration failed
      // ...
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            // Customize the colors here
            primarySwatch: Colors.blue, // Header color
            accentColor: Colors.blue, // Selection color
            colorScheme:
                ColorScheme.light(primary: Colors.blue), // Calendar days color
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            // Customize the colors here
            primarySwatch: Colors.blue, // Header color
            accentColor: Colors.blue, // Selection color
            colorScheme:
                ColorScheme.light(primary: Colors.blue), // Clock face color
            dialogBackgroundColor: Colors.white, // Background color
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  List<String> categoryTypes = ['']; // List to store category types
  String selectedCategoryType = ''; // Currently selected category type

  @override
  void initState() {
    super.initState();
    fetchCategoryTypes(); // Fetch category types when the form is initialized
  }

  Future<void> fetchCategoryTypes() async {
    final apiUrl = 'http://127.0.0.1:8000/api/eventcategorydetails';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data); // Print the response body for debugging

        if (data is List) {
          final List<String> categories = data
              .map((category) => category['event_category'].toString())
              .toList();

          setState(() {
            categoryTypes = categories;
          });

          return;
        }
      } else {
        print(
            'Failed to fetch category types. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to fetch category types: $error');
    }

    // Handle the error case, for example, show an error message to the user.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Registration Form'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: eventNameController,
                  decoration: InputDecoration(
                    labelText:
                        eventNameController.text.isEmpty ? 'Event Name' : '',
                    labelStyle: TextStyle(color: Colors.black),
                    floatingLabelBehavior: eventNameController.text.isNotEmpty
                        ? FloatingLabelBehavior.never
                        : FloatingLabelBehavior.auto,
                    enabled: eventNameController.text.isEmpty,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event name.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: eventOrganiserController,
                  decoration: const InputDecoration(
                      labelText: 'Event Organiser',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event organiser.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: eventContactController,
                  decoration: const InputDecoration(
                      labelText: 'Event Contact',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event contact.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: eventAddressController,
                  decoration: const InputDecoration(
                    labelText: 'Event Address',
                    labelStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.symmetric(
                        vertical:
                            16.0), // Adjust the value to increase or decrease line height
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event address.';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Edate',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (selectedDate == null) {
                          return 'Please select a date.';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                        text: selectedDate != null
                            ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                            : '',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _selectTime(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Event Time',
                        labelStyle: TextStyle(color: Colors.black),
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      validator: (value) {
                        if (selectedTime == null) {
                          return 'Please select a time.';
                        }
                        return null;
                      },
                      controller: TextEditingController(
                        text: selectedTime != null
                            ? selectedTime!.format(context)
                            : '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      setState(() {
                        selectedImage = File(pickedFile.path);
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // Replace with your desired color
                  ),
                  child: Text(selectedImage != null
                      ? 'Image Selected'
                      : 'Select Image'),
                ),
                TextFormField(
                  controller: eventDescController,
                  decoration: const InputDecoration(
                      labelText: 'Event Description',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the event description.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: bookingLinkController,
                  decoration: const InputDecoration(
                      labelText: 'Booking Link',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the booking link.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: directionController,
                  decoration: const InputDecoration(
                      labelText: 'Google Map',
                      labelStyle: TextStyle(color: Colors.black)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the direction.';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  value: selectedCategoryType.isEmpty
                      ? null
                      : selectedCategoryType,
                  items: categoryTypes.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryType = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category Type',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category type.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // Replace with your desired color
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // All fields are valid, submit the form
                      registerEvent();
                    }
                  },
                  child: const Text(
                    'Register',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
