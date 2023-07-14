import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';
import 'package:yellowpage/views/registration_screen.dart/cont_registration.dart';
import 'package:yellowpage/views/registration_screen.dart/eregistrationform.dart';
import 'package:yellowpage/views/registration_screen.dart/event_registration.dart';
// import 'package:yellowpage/widgets_common/contact_registration_form.dart';

import '../homeScreen/home.dart';
import 'contact_registration.dart';
// import 'package:yellowpage/consts/strings.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home())),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Registration',
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
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: lightGrey),
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Yellow',
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Page',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Raleway,",
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(top: 6),
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: 30,
                child: const Text(
                  'Get Register your Business & Events',
                  style: TextStyle(
                      fontFamily: "Raleway",
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Contact Registration',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContRegistrationForm()));
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'Event Registration',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 1),
                        ),
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventRegistrationForm()));
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/event.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
