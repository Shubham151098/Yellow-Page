import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';
import 'package:yellowpage/model/events.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.events});
  final Events events;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(events.eimage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        leading: IconButton(
          alignment: AlignmentDirectional.topStart,
          color: whiteColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Add your onPressed
            //logic here
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(155, 226, 226, 226),
                        borderRadius: BorderRadius.circular(50)),
                    child: Text(
                      events.categoryType.eventCategory,
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 15,
                          letterSpacing: 1,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        events.eventname,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: Colors.amber),
                            height: 40,
                            width: 40,
                            child: const Icon(
                              Icons.date_range,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat('dd-MMMM-yyyy').format(events.edate),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    color: Colors.amber),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                DateFormat('hh:mm a').format(DateTime.parse(
                                    '2022-01-01 ${events.etime}')),
                                style: const TextStyle(
                                  fontSize: 17,
                                  letterSpacing: 1,
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  color: fontGrey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: Colors.amber),
                            height: 40,
                            width: 40,
                            child: const Icon(
                              Icons.location_on,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                events.eaddress,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                events.organiserName,
                                style: const TextStyle(
                                    color: fontGrey,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        events.edesc,
                        style: const TextStyle(
                            fontFamily: 'Raleway',
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            wordSpacing: 1),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: double.infinity,
                        height: 50,
                        child: const Text(
                          'Get Direction',
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                              color: Colors.white),
                        ),
                      ).onTap(() {
                        final googleMapsLink =
                            'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(events.eaddress)}';
                        launchUrl(Uri.parse(googleMapsLink));
                      }),
                      // Container(
                      //   height: 250,
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.all(10),
                      //   color: amber,
                      //   child: InAppWebView(
                      //     initialUrlRequest:
                      //         URLRequest(url: Uri.parse(events.direction)),
                      //     // initialUrl: events.direction,
                      //     // javascriptMode: JavascriptMode.unrestricted,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: amber,
                                borderRadius: BorderRadius.circular(6)),
                            width: 150,
                            height: 40,
                            child: const Text(
                              'CONTACT',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: whiteColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                            ),
                          ).onTap(() async {
                            Uri phoneno =
                                Uri.parse('tel:${events.eventContact}');
                            if (await launchUrl(phoneno)) {
                              //dialer opened
                            } else {
                              //dailer is not opened
                            }
                          }),
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: amber,
                                borderRadius: BorderRadius.circular(6)),
                            width: 150,
                            height: 40,
                            child: const Text(
                              'BOOK EVENT',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  color: whiteColor,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1),
                            ),
                          ).onTap(
                              () => launchUrl(Uri.parse(events.bookingLink))),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:yellowpage/consts/colors.dart';
// import 'package:yellowpage/model/events.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class EventDetails extends StatelessWidget {
//   const EventDetails({Key? key, required this.events}) : super(key: key);
//   final Events events;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 200,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: NetworkImage(events.eimage),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         leading: IconButton(
//           alignment: AlignmentDirectional.topStart,
//           color: whiteColor,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         width: context.screenWidth,
//         height: context.screenHeight,
//         color: lightGrey,
//         child: SafeArea(
//           child: Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(155, 226, 226, 226),
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                     child: Text(
//                       events.categoryType.eventCategory,
//                       style: const TextStyle(
//                         color: Colors.amber,
//                         fontSize: 15,
//                         letterSpacing: 1,
//                         fontFamily: 'Raleway',
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 3),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         events.eventname,
//                         style: const TextStyle(
//                           fontFamily: 'Raleway',
//                           fontWeight: FontWeight.w600,
//                           fontSize: 30,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(500),
//                               color: Colors.amber,
//                             ),
//                             height: 40,
//                             width: 40,
//                             child: const Icon(
//                               Icons.date_range,
//                               size: 20,
//                             ),
//                           ),
//                           const SizedBox(width: 40),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 DateFormat('dd-MMMM-yyyy').format(events.edate),
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w600,
//                                   letterSpacing: 1,
//                                   color: Colors.amber,
//                                 ),
//                               ),
//                               const SizedBox(height: 3),
//                               Text(
//                                 DateFormat('hh:mm a').format(
//                                   DateTime.parse('2022-01-01 ${events.etime}'),
//                                 ),
//                                 style: const TextStyle(
//                                   fontSize: 17,
//                                   letterSpacing: 1,
//                                   fontFamily: 'Raleway',
//                                   fontWeight: FontWeight.w600,
//                                   color: fontGrey,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(500),
//                               color: Colors.amber,
//                             ),
//                             height: 40,
//                             width: 40,
//                             child: const Icon(
//                               Icons.location_on,
//                               size: 20,
//                             ),
//                           ),
//                           const SizedBox(width: 40),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 events.eaddress,
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 events.organiserName,
//                                 style: const TextStyle(
//                                   color: fontGrey,
//                                   letterSpacing: 1,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         events.edesc,
//                         style: const TextStyle(
//                           fontFamily: 'Raleway',
//                           letterSpacing: 1.5,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 15,
//                           wordSpacing: 1,
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Container(
//                         height: 250,
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(10),
//                         color: amber,
//                         child: InAppWebView(
//                           initialUrlRequest:
//                               URLRequest(url: Uri.parse(events.direction)),
//                         ),
//                       ),
//                       const SizedBox(height: 15),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: amber,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             width: 150,
//                             height: 40,
//                             child: const Text(
//                               'CONTACT',
//                               style: TextStyle(
//                                 fontFamily: 'Raleway',
//                                 color: whiteColor,
//                                 fontWeight: FontWeight.w700,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ).onTap(() async {
//                             Uri phoneNumber =
//                                 Uri.parse('tel:${events.eventContact}');
//                             if (await launchUrl(phoneNumber)) {
//                               // Dialer opened
//                             } else {
//                               // Dialer is not opened
//                             }
//                           }),
//                           Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: amber,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             width: 150,
//                             height: 40,
//                             child: const Text(
//                               'BOOK EVENT',
//                               style: TextStyle(
//                                 fontFamily: 'Raleway',
//                                 color: whiteColor,
//                                 fontWeight: FontWeight.w700,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ).onTap(
//                               () => launchUrl(Uri.parse(events.bookingLink))),
//                           TextButton(
//                             onPressed: () {
//                               final googleMapsLink =
//                                   'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(events.eaddress)}';
//                               launchUrl(Uri.parse(googleMapsLink));
//                             },
//                             child: const Text(
//                               'OPEN IN MAPS',
//                               style: TextStyle(
//                                 fontFamily: 'Raleway',
//                                 color: whiteColor,
//                                 fontWeight: FontWeight.w700,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
