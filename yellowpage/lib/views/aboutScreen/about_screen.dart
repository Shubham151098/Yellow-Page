import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';

import '../homeScreen/home.dart';

// import 'package:yellowpage/consts/strings.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                  'About',
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
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(color: Colors.blueGrey),
                    child: const Text('Logo'),
                  ),
                ],
              ),
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
                  'Developed by Crescive Technologies',
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
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Contact : +91 8458965847'),
                    SizedBox(
                      height: 2,
                    ),
                    Text('Support: support@gmail.com'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
