import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:interviews/data/fruit_data.dart';
import '../contstants.dart';
import '../data/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  List imageUrls = [];
  List age = [];
  List description = [];
  List likeCount = [];
  List location = [];
  List tags = [];
  List names = [];
  int currentIndex = 0;

  Future<List> getFruits() async {
    final List fruits = [];
    final needsSnapshot =
        await FirebaseDatabase.instance.reference().child("data").get();

    print(needsSnapshot); // to debug and see if data is returned

    final map = needsSnapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final fruit = Fruit.fromMap(value);

      imageUrls.add(fruit.images);
      age.add(fruit.age);
      description.add(fruit.description);
      likeCount.add(fruit.likeCount);
      location.add(fruit.location);
      tags.add(fruit.tags);
      location.add(fruit.location);
      names.add(fruit.name);
    });
    print("Retuned objects ${age}");

    return fruits!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFruits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: luvitAppbar(
        context: context,
        likeCount: '35',
        location: 'Seoul',
      ),
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          // Get the RenderBox for the widget, and then translate the global
          // position into local coordinates.
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localPosition =
              box.globalToLocal(details.globalPosition);
          final double halfWidth = box.size.width / 2;

          // Check the position and update the state accordingly
          if (localPosition.dx < halfWidth) {
            // Left half tapped
            setState(() {
              if (currentIndex > 0) {
                currentIndex--;
              }
            });
          } else {
            // Right half tapped
            setState(() {
              if (currentIndex < imageUrls.length - 1) {
                currentIndex++;
              }
            });
          }
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Stack(
                    fit: StackFit.expand,
                    children: [
                      for (var i = 0; i < imageUrls.length; i++)
                        Visibility(
                          visible: currentIndex == i,
                          child: Image.network(
                            imageUrls[0][i],
                            fit: BoxFit.cover,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    names[0],

                                    style: const TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                verticalSpace(5),
                                Text(age[0].toString(),
                                    style: TextStyle(fontSize: 20))
                              ],
                            )),
                        Flexible(
                          child: Text(
                            description[0],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

      //
      // FutureBuilder<DataSnapshot>(
      //   future: databaseReference.child('data').onValue.listen((event) { })
      //   builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return CircularProgressIndicator();
      //     } else if (snapshot.hasError) {
      //       return Text('Error: ${snapshot.error}');
      //     } else {
      //       if (snapshot.hasData && snapshot.data!.value != null) {
      //         Map<dynamic, dynamic> values = snapshot.data!.value;
      //         List<Widget> fruits = [];
      //
      //         values.forEach((key, value) {
      //           List<Widget> images = [];
      //           for (var imageUrl in value['images']) {
      //             images.add(
      //               Image.network(
      //                 imageUrl,
      //                 height: 100,
      //                 width: 100,
      //               ),
      //             );
      //           }
      //           fruits.add(
      //             Column(
      //               children: [
      //                 Stack(
      //                   alignment: AlignmentDirectional.bottomCenter,
      //                   children: images,
      //                 ),
      //                 Text(value['description']),
      //               ],
      //             ),
      //           );
      //         });
      //
      //         return ListView(
      //           children: fruits,
      //         );
      //       }
      //       return Text('No data found');
      //     }
      //   },
    );
  }
}
