import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yellowpage/views/eventScreen/event_details.dart';
import 'dart:convert';
import '../../model/events.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yellowpage/env.sample.dart';

class EventCategoryBox extends StatefulWidget {
  const EventCategoryBox({super.key});

  @override
  State<EventCategoryBox> createState() => _EventCategoryBoxState();
}

class _EventCategoryBoxState extends State<EventCategoryBox> {
  Future<List<Events>>? events;
  final eventListKey = GlobalKey<_EventCategoryBoxState>();

  @override
  void initState() {
    super.initState();
    events = getEventList();
  }

  Future<List<Events>> getEventList() async {
    // String url =
    //     "http://127.0.0.1:8000/api/eventsdetails?_sort=created_at:ASC&_limit=2";
    final response =
        // await http.get(Uri.parse("${Env.urlPrefix}/api/eventsdetails"));
        await http.get(Uri.parse("http://${Env.urlPrefix}/api/eventsdetails"));
    // final response = await http.get("${Env.urlPrefix}/api/eventsdetails");
    // String url =
    // "http://127.0.0.1:8000/api/eventsdetails?_sort=created_at:ASC&_limit=2";
    // final response = await http.get("${urlPrefix}/api/eventsdetails");
    // final response = await http.get(Uri.parse(url));
    // final response = await http.get(Uri.parse(url));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Events> events = items.map<Events>((json) {
      return Events.fromJson(json);
    }).toList();

    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      width: context.screenWidth,
      height: 200, // Adjust this value to reduce the height of the container
      child: Center(
        child: FutureBuilder<List<Events>>(
          future: events,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (snapshot.hasError) {
              // print("Error: ${snapshot.error}");
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) return const CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetails(events: snapshot.data[index]),
                            ),
                          );
                        },
                        leading: Image.network(data.eimage),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.eventname,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                            ),
                            Text(data.eaddress),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
