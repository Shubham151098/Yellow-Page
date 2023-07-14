// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/consts/colors.dart';
import 'package:yellowpage/model/events.dart';
import 'package:yellowpage/views/eventScreen/event_details.dart';
import 'package:yellowpage/views/homeScreen/home.dart';
import 'package:yellowpage/views/registration_screen.dart/eregistrationform.dart';
// import 'package:yellowpage/widgets_common/contact_registration_form.dart';

// import '../registration_screen.dart/contact_registration.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool _sortAscending = true;
  List<Events> _eventsList = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/eventsdetails'));
    // await http.get(Uri.parse('http://10.0.2.2:8000/api/eventsdetails'));
    if (response.statusCode == 200) {
      setState(() {
        _eventsList = eventsFromJson(response.body);
      });
    } else {
      throw Exception('Failed to fetch events');
    }
  }

  void _sortEvents() {
    setState(() {
      if (_sortAscending) {
        _eventsList.sort((a, b) => a.edate.compareTo(b.edate));
      } else {
        _eventsList.sort((a, b) => b.edate.compareTo(a.edate));
      }
      _sortAscending = !_sortAscending;
    });
  }

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

// Button for sorting events by date

            // ElevatedButton(
            //   onPressed: _sortEvents,
            //   child: Row(
            //     children: [
            //       Text(
            //         'Sort',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 16,
            //         ),
            //       ),
            //       Icon(
            //         _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
            //         color: Colors.white,
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.amber[300], shape: BoxShape.circle),
              child: const Icon(Icons.sort),
            ).onTap(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventRegistrationForm()));
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(
                  color: lightGrey, borderRadius: BorderRadius.zero),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: _sortEvents,
                    child: Row(
                      children: [
                        const Text(
                          'Sort by Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          _sortAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                decoration: const BoxDecoration(color: lightGrey),
                height: context.screenHeight,
                child: _buildEventsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    if (_eventsList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: _eventsList.length,
        itemBuilder: (context, index) {
          final event = _eventsList[index];
          return Column(
            children: [
              Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EventDetails(events: event),
                      ),
                    );
                  },
                  leading: Image.network(event.eimage),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventname,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      Text(event.eaddress),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
