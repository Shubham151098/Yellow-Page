import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';
// import 'package:yellowpage/views/registration_screen.dart/contact_registration.dart';
import 'package:yellowpage/views/contact_page/contact_category.dart';
import 'package:yellowpage/views/eventScreen/event_screen.dart';
import 'package:yellowpage/widgets_common/category_box.dart';
import 'package:yellowpage/widgets_common/contact_registration_form.dart';

import '../../widgets_common/event_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            width: context.screenWidth,
            color: whiteColor,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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

                      // Add Section
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.amber[300], shape: BoxShape.circle),
                        child: const Icon(Icons.add),
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactForm()));
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/event.jpg', height: 220),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Call Directories',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: 'raleway',
                        ),
                      ),
                      const Text(
                        'See All',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactCategory()));
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  // Categories Section

                  const CategoryBox(),
                  const SizedBox(
                    height: 35,
                  ),

                  //  Events Heading
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: 'raleway',
                        ),
                      ),
                      const Text(
                        'See All',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EventScreen()));
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const EventCategoryBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
