import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/strings.dart';
import 'package:yellowpage/views/homeScreen/home.dart';
import 'package:yellowpage/widgets_common/applogo_widget.dart';
// import 'package:yellowpage/consts/consts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.to(() => const Home());
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Vx.yellow400,
        body: Center(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 400,
                  height: 300,
                ),
              ),
              20.heightBox,
              applogoWidget(),
              10.heightBox,
              appname.text.fontFamily('poppins').size(22).white.make(),
              5.heightBox,
              appversion.text.gray200.make(),
              const Spacer(),
              credits.text.fontFamily('poppins').white.make(),
              30.heightBox,
            ],
          ),
        ));
  }
}
