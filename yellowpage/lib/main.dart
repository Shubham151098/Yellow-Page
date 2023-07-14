import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellowpage/consts/colors.dart';
import 'package:yellowpage/views/splashScreen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yellow Page',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.transparent,
        colorScheme: const ColorScheme.light(primary: lightGrey),
        appBarTheme: const AppBarTheme(
            elevation: 1,
            iconTheme: IconThemeData(color: darkFontGrey),
            titleTextStyle: TextStyle(color: darkFontGrey, fontSize: 22),
            backgroundColor: lightGrey),
      ),
      home: const SplashScreen(),
    );
  }
}
