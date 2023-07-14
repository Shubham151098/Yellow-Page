import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../controllers/api_controller.dart';
import '../model/usermodel.dart';
import '../views/contact_page/members_page.dart';

class CategoryBox extends StatefulWidget {
  const CategoryBox({super.key});

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        width: context.screenWidth,
        height: 100,
        child: Center(
          child: FutureBuilder<List<Fields>>(
              future: ApiProvider().getUsers(),
              builder: (context, snapshot) {
                final data = snapshot.data;
                if (snapshot.hasData) {
                  return Container(
                    color: Colors.white,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5),
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: ((context, index) {
                        final fields = data![index];
                        return Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(1, 1))
                                ],
                              ),
                              child:
                                  Image.network(fields.fimage, cacheHeight: 30),
                            ),
                            const SizedBox(
                              height: 10,
                              width: 50,
                            ),
                            Text(
                              fields.fname,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontFamily: 'Raleway'),
                            )
                          ],
                        ).onTap(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MembersPage(members: data[index].members),
                            ),
                          );
                        });
                      }),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ));
  }
}
