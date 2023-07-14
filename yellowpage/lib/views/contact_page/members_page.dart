import 'package:flutter/material.dart';
import '../../model/usermodel.dart';
// ignore: unused_import
import 'package:favorite_button/favorite_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MembersPage extends StatefulWidget {
  final List<Member> members;
  const MembersPage({required this.members, Key? key}) : super(key: key);

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: widget.members.length,
          itemBuilder: (context, index) {
            final members = widget.members[index];
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(child: Text(members.mname[0])),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        members.mname,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () async {
                        Uri phoneno = Uri.parse('tel:${members.mnumber}');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                      child: const Text("Call")),
                  subtitle: Text(
                    members.mnumber.toString(),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
