import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yellowpage/consts/colors.dart';
import 'package:yellowpage/consts/images.dart';
import 'package:yellowpage/consts/strings.dart';
import 'package:yellowpage/controllers/home_controller.dart';
import 'package:yellowpage/views/aboutScreen/about_screen.dart';
// import 'package:yellowpage/views/registration_screen.dart/contact_registration.dart';
import 'package:yellowpage/views/contact_page/contact_category.dart';
import 'package:yellowpage/views/eventScreen/event_screen.dart';
import 'package:yellowpage/views/registration_screen.dart/registration.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategory,
            width: 26,
          ),
          label: contacts),
      BottomNavigationBarItem(
          icon: Image.asset(
            icEvent,
            width: 26,
          ),
          label: events),
      BottomNavigationBarItem(
          icon: Image.asset(
            icAbout,
            width: 26,
          ),
          label: registration),
      BottomNavigationBarItem(
          icon: Image.asset(
            icSave,
            width: 26,
          ),
          label: 'About'),
    ];

    var navBody = [
      const HomeScreen(),
      const ContactCategory(),
      const EventScreen(),
      const Registration(),
      const AboutScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
              child: navBody.elementAt(controller.currentNavIndex.value))),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: amber,
          selectedLabelStyle: const TextStyle(fontSize: 15),
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          items: navbarItem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       color: lightGrey,
//       width: context.screenWidth,
//       height: context.screenHeight,
//       child: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               height: 60,
//               color: lightGrey,
//               child: TextFormField(
//                 decoration: const InputDecoration(
//                   border: InputBorder.none,
//                   suffixIcon: Icon(Icons.search),
//                   filled: true,
//                   fillColor: whiteColor,
//                   hintText: searchforcontacts,
//                   hintStyle: TextStyle(color: textfieldGrey),
//                 ),
//               ),
//             ),
//             10.heightBox,
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   children: [
//                     // Swiper Contacts
//                     VxSwiper.builder(
//                         aspectRatio: 16 / 9,
//                         autoPlay: true,
//                         height: 150,
//                         enlargeCenterPage: true,
//                         itemCount: sliderstList.length,
//                         itemBuilder: (context, index) {
//                           return Image.asset(
//                             sliderstList[index],
//                             fit: BoxFit.fill,
//                           )
//                               .box
//                               .rounded
//                               .clip(Clip.antiAlias)
//                               .margin(const EdgeInsets.symmetric(horizontal: 8))
//                               .make();
//                         }),
//                     20.heightBox,

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: List.generate(
//                           2,
//                           (index) => homeButtons(
//                                 height: context.screenHeight * 0.15,
//                                 width: context.screenWidth / 2.5,
//                                 icon: index == 0 ? icAbout : icHome,
//                                 title: index == 0 ? plumber : washerman,
//                               )),
//                     ),

//                     // 2nd Swipers
//                     10.heightBox,

//                     // VxSwiper.builder(
//                     //     aspectRatio: 16 / 9,
//                     //     autoPlay: true,
//                     //     height: 150,
//                     //     enlargeCenterPage: true,
//                     //     itemCount: sliderstList.length,
//                     //     itemBuilder: (context, index) {
//                     //       return Image.asset(
//                     //         sliderstList[index],
//                     //         fit: BoxFit.fill,
//                     //       )
//                     //           .box
//                     //           .rounded
//                     //           .clip(Clip.antiAlias)
//                     //           .margin(EdgeInsets.symmetric(horizontal: 8))
//                     //           .make();
//                     //     }),

//                     // 10.heightBox,
//                     // Row(
//                     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     //   children: List.generate(
//                     //       3,
//                     //       (index) => homeButtons(
//                     //             height: context.screenHeight * 0.15,
//                     //             width: context.screenWidth / 3.5,
//                     //             icon: index == 0
//                     //                 ? icCategory
//                     //                 : index == 1
//                     //                     ? icAbout
//                     //                     : icHome,
//                     //             title: index == 0
//                     //                 ? categories
//                     //                 : index == 1
//                     //                     ? searchforcontacts
//                     //                     : plumber,
//                     //           )),
//                     // ),

//                     // featured categories
//                     // 20.heightBox,
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: featuredCategories.text
//                           .color(darkFontGrey)
//                           .size(18)
//                           .fontFamily('poppins')
//                           .make(),
//                     ),
//                     // 20.heightBox,
//                     // SingleChildScrollView(
//                     //   scrollDirection: Axis.horizontal,
//                     //   child: Row(
//                     //     children: List.generate(
//                     //       3,
//                     //       (index) => Column(
//                     //         children: [
//                     //           featuredButton(
//                     //               icon: featuredImages1[index],
//                     //               title: featuredTitles1[index]),
//                     //           10.heightBox,
//                     //           featuredButton(
//                     //               icon: featuredImages2[index],
//                     //               title: featuredTitles2[index]),
//                     //         ],
//                     //       ),
//                     //     ).toList(),
//                     //   ),
//                     // ),

//                     // featured product
//                     20.heightBox,
//                     // Container(
//                     //   padding: EdgeInsets.all(12),
//                     //   width: double.infinity,
//                     //   decoration: const BoxDecoration(color: Vx.amber400),
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       featuredContact.text.white
//                     //           .fontFamily('poppins')
//                     //           .size(18)
//                     //           .make(),
//                     //       10.heightBox,
//                     //       SingleChildScrollView(
//                     //         scrollDirection: Axis.horizontal,
//                     //         child: Row(
//                     //           children: List.generate(
//                     //               6,
//                     //               (index) => Column(
//                     //                     crossAxisAlignment:
//                     //                         CrossAxisAlignment.start,
//                     //                     children: [
//                     //                       Image.asset(imgSlider1,
//                     //                           width: 150, fit: BoxFit.cover),
//                     //                       10.heightBox,
//                     //                       watchman.text
//                     //                           .fontFamily('poppins')
//                     //                           .color(darkFontGrey)
//                     //                           .make(),
//                     //                       10.heightBox,
//                     //                     ],
//                     //                   )
//                     //                       .box
//                     //                       .height(120)
//                     //                       .margin(const EdgeInsets.symmetric(
//                     //                           horizontal: 4))
//                     //                       .white
//                     //                       .roundedSM
//                     //                       .padding(const EdgeInsets.all(8))
//                     //                       .make()),
//                     //         ),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     // 20.heightBox,
//                     GridView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: 6,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: 8,
//                               crossAxisSpacing: 8,
//                               mainAxisExtent: 300),
//                       itemBuilder: (context, index) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.asset(imgSlider2,
//                                 width: 200, height: 200, fit: BoxFit.cover),
//                             const Spacer(),
//                             watchman.text
//                                 .fontFamily('poppins')
//                                 .color(darkFontGrey)
//                                 .make(),
//                             10.heightBox,
//                           ],
//                         )
//                             .box
//                             .height(120)
//                             .margin(const EdgeInsets.symmetric(horizontal: 4))
//                             .white
//                             .roundedSM
//                             .padding(const EdgeInsets.all(12))
//                             .make();
//                       },
//                     ),

//                     // All contacts
//                     10.heightBox,
//                     SizedBox(
//                       width: double.infinity,
//                       height: 60,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           textStyle: const TextStyle(fontSize: 20),
//                           backgroundColor: Colors.amber,
//                           fixedSize: const Size.fromWidth(100),
//                           padding: const EdgeInsets.all(10),
//                         ),
//                         child: const Text('Sell All'),
//                         onPressed: () {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
