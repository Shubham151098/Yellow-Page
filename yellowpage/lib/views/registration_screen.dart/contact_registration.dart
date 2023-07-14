import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';
import 'dart:convert';
import 'dart:io';
import '../../model/contact_registration.dart';
import '../homeScreen/home.dart';
import 'package:file_picker/file_picker.dart';

class ContactRegistrationForm extends StatefulWidget {
  const ContactRegistrationForm({super.key});

  @override
  State<ContactRegistrationForm> createState() =>
      _ContactRegistrationFormState();
}

class _ContactRegistrationFormState extends State<ContactRegistrationForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<CityName> _cityNames = [];
  String _selectedCity = "";

  List<BusinessType> _businessType = [];
  String _selectedBusinessType = "";

  File? _selectedImage;
  File? _selectedPdf;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactsController = TextEditingController();
  final TextEditingController _alternateContactsController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _contactsController.dispose();
    _alternateContactsController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchCityNames();
    fetchBusinessTypes();
  }

  Future<void> fetchBusinessTypes() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/fieldsdetails'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        _businessType = jsonData
            .map<BusinessType>((item) => BusinessType.fromJson(item))
            .toList();
      });
    } else {
      // Handle error
    }
  }

  Future<void> fetchCityNames() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/citynamedetails'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // Create a set to keep track of unique city names
      final uniqueCityNames = <String>{};

      // Iterate over the received data and add unique city names to the set
      for (var item in jsonData) {
        final cityName = CityName.fromJson(item).cityName;
        uniqueCityNames.add(cityName);
      }

      // Convert the set back to a list and assign it to _cityNames
      setState(() {
        _cityNames = uniqueCityNames
            .map<CityName>((cityName) => CityName(cityName: cityName))
            .toList();
      });
    } else {
      // Handle error
    }
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  void _selectPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _selectedPdf = File(result.files.first.path!);
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String name = _nameController.text;
      String email = _emailController.text;
      String contacts = _contactsController.text;
      String alternateContacts = _alternateContactsController.text;
      String address = _addressController.text;

      // Create an instance of the ContactRegistration model
      ContactRegistration contactRegistration = ContactRegistration(
        id: 0, // Assign a default value as per your requirements
        rname: name,
        remail: email,
        rcontacts: contacts,
        rcontactsAlternate: alternateContacts,
        raddress: address,
        rcity: Rcity(
          id: 0, // Assign a default value as per your requirements
          cityName: _selectedCity,
        ),
        businessType: 0, // Assign a default value as per your requirements
        rimage: '', // Assign a default value as per your requirements
        rdocument: '', // Assign a default value as per your requirements
      );

      // Convert the ContactRegistration object to JSON
      String jsonContactRegistration =
          contactRegistrationToJson([contactRegistration]);

      // Send the JSON data to your desired destination
      // For example, you can send it to a server using the http package
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/contactregistrationdetails'),
        body: jsonContactRegistration,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Request successful, do something with the response

        // Reset the form
        _formKey.currentState!.reset();

        // Clear the selected image and PDF
        setState(() {
          _selectedImage = null;
          _selectedPdf = null;
        });

        _showSuccessSnackBar('Form submitted successfully');
      } else {
        _showErrorSnackBar('Failed to submit the form');
        // Request failed, handle the error
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home())),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Yellow',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Page',
                  style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ]),
        ),
        body: Container(
          // padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: context.screenWidth,
          height: context.screenHeight,
          color: lightGrey,
          child: SafeArea(
              child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(115, 226, 226, 226),
                        borderRadius: BorderRadius.circular(50)),
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
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Name is required';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {},
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Email',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Contacts',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    keyboardType: TextInputType.phone,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Alternate Contacts',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    keyboardType: TextInputType.phone,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        labelText: 'Address',
                                        labelStyle:
                                            TextStyle(color: Colors.black)),
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 10),
                                  const SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    decoration:
                                        const BoxDecoration(color: Colors.cyan),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    child: const Text('Select Your City',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Raleway'),
                                        textAlign: TextAlign.start),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    decoration:
                                        const BoxDecoration(color: Colors.cyan),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 5,
                                    ),
                                    child: const Text(
                                      'Please select your business type',
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'Raleway'),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: _businessType.map((businessType) {
                                      return RadioListTile<String>(
                                        title: Text(businessType.businessType),
                                        value: businessType.businessType,
                                        groupValue: _selectedBusinessType,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedBusinessType = value!;
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              labelText: 'Upload Your Image',
                                              labelStyle: TextStyle(
                                                  color: Colors.black)),
                                          initialValue: _selectedImage != null
                                              ? _selectedImage!.path
                                              : '',
                                          readOnly: true,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.photo),
                                        onPressed: _selectImage,
                                        tooltip: 'Select Image',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                              labelText: 'PDF Path',
                                              labelStyle: TextStyle(
                                                  color: Colors.black)),
                                          initialValue: _selectedPdf != null
                                              ? _selectedPdf!.path
                                              : '',
                                          readOnly: true,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.attach_file),
                                        onPressed: _selectPdf,
                                        tooltip: 'Select PDF',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: _submitForm,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    child: const Text('Submit'),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ));
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

class BusinessType {
  final String businessType;

  BusinessType({required this.businessType});

  factory BusinessType.fromJson(Map<String, dynamic> json) {
    return BusinessType(
      businessType: json['fname'],
    );
  }
}
