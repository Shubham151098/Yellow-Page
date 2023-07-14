import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/cont_registration_model.dart';
import 'package:http_parser/http_parser.dart' as http_parser;

class Field {
  final int id;
  final String name;
  final String image;

  Field({required this.id, required this.name, required this.image});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['id'],
      name: json['fname'],
      image: json['fimage'],
    );
  }
}

class City {
  final int id;
  final String? name;

  City({required this.id, this.name});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['city_name'] as String?,
    );
  }

  @override
  String toString() {
    return name ?? '';
  }
}

class ContRegistrationForm extends StatefulWidget {
  const ContRegistrationForm({super.key});

  @override
  _ContRegistrationFormState createState() => _ContRegistrationFormState();
}

class _ContRegistrationFormState extends State<ContRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  City? _selectedCity; // Add this line to hold the selected city

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _alternateContactController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();

  PlatformFile? _document;
  String? _documentName;
  XFile? _image;
  List<City> _cities = [];
  Field? _selectedField; // Add this line to hold the selected field
  List<Field> _fields = [];

  @override
  void initState() {
    super.initState();
    fetchCities();
    fetchFields();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ContRegistration Form'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contactController,
                      decoration: const InputDecoration(
                          labelText: 'Contact',
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a contact number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _alternateContactController,
                      decoration: const InputDecoration(
                          labelText: 'Alternate Contact',
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Set the button color
                        ),
                        child: const Text('Select Image'),
                      ),
                    ),
                    if (_image != null) Image.file(File(_image!.path)),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          pickDocument();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue), // Change the button color here
                        ),
                        child: const Text('Select Document'),
                      ),
                    ),
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: 'City',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      items: _cities.map((city) {
                        return DropdownMenuItem<int>(
                          value: city.id, // Set the value to city's id
                          child: Text(city.name ?? '',
                              style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      value: _selectedCity
                          ?.id, // Set the selected city's id as the value
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a city';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedCity =
                              _cities.firstWhere((city) => city.id == value);
                        });
                      },
                    ),
                    DropdownButtonFormField<Field>(
                      decoration: const InputDecoration(
                        labelText: 'Field',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      items: _fields.map((field) {
                        return DropdownMenuItem<Field>(
                          value: field,
                          child: Text(
                            field.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      value: _selectedField, // Set the selected field object
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a field';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedField = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, submit the data
                          submitForm();
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
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

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String name = _nameController.text;
      String email = _emailController.text;
      String contact = _contactController.text;
      String alternateContact = _alternateContactController.text;
      String address = _addressController.text;
      String businessType = _businessTypeController.text;

      ContRegistration registration = ContRegistration(
        id: 0,
        name: name,
        email: email,
        contact: contact,
        alternateContact: alternateContact,
        address: address,
        image: '',
        document: _document?.name ?? '',
        city: _selectedCity?.id ?? 0,
        businessType: _selectedField?.id ?? 0,
      );

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/register-contact/'),
      );

      // Remove the JSON data from the request
      // request.fields['data'] = jsonData;

      if (_image != null) {
        final imageFile = File(_image!.path);
        final imageStream =
            http.ByteStream(Stream.castFrom(imageFile.openRead()));
        final imageLength = await imageFile.length();
        final imageUpload = http.MultipartFile(
          'image',
          imageStream,
          imageLength,
          filename: _image!.name,
          contentType: http_parser.MediaType('image', 'jpeg'),
        );
        request.files.add(imageUpload);
      }

      if (_document != null) {
        final documentFile = File(_document!.path!);
        final documentStream =
            http.ByteStream(Stream.castFrom(documentFile.openRead()));
        final documentLength = await documentFile.length();
        final documentUpload = http.MultipartFile(
          'document',
          documentStream,
          documentLength,
          filename: _document!.name!,
          contentType: http_parser.MediaType('application', 'pdf'),
        );
        request.files.add(documentUpload);
      }

      // Set the content type of the request
      request.headers['Content-Type'] = 'multipart/form-data';

      // Send the request
      try {
        final response = await request.send();

        if (response.statusCode == 200) {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: const Text('Form submitted successfully'),
            ),
          );
        } else {
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: const Text('Failed to submit form'),
            ),
          );
          print('Failed to submit form: ${response.statusCode}');
          print('Response body: ${await response.stream.bytesToString()}');
        }
      } catch (e) {
        print('Error: $e');
        _scaffoldMessengerKey.currentState?.showSnackBar(
          SnackBar(
            content: const Text('An error occurred while submitting the form'),
          ),
        );
      }
    }
  }

  Future<void> fetchFields() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/fieldsdetails'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Field> fields =
            data.map((field) => Field.fromJson(field)).toList();
        setState(() {
          _fields = fields;
        });
        print('API Response Body: $data'); // Log the response body
      } else {
        print('Failed to fetch field data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchCities() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:8000/api/citynamedetails'));
      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        final List<dynamic> data = jsonDecode(response.body);
        List<City> cities = data.map((city) => City.fromJson(city)).toList();
        setState(() {
          _cities = cities;
        });
      } else {
        print('Failed to fetch city data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _document = result.files.single;
        _documentName = _document?.name;
      });
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text('File uploaded: $_documentName'),
        ),
      );
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ContRegistration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContRegistrationForm(),
    );
  }
}
