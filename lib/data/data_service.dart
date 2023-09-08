import 'package:firebase_database/firebase_database.dart';

import 'fruit_data.dart';


class DatabaseService {


   Future<List> getFruits() async {
     final List fruits=[];
    final needsSnapshot = await FirebaseDatabase.instance
        .reference()
        .child("data").get();


    print(needsSnapshot); // to debug and see if data is returned




    final map = needsSnapshot.value as Map<dynamic, dynamic>;

    map.forEach((key, value) {
      final fruit = Fruit.fromMap(value);

      fruits.add(fruit.location);
    });
    print("Retuned objects ${fruits}");

    return fruits!;
  }
}