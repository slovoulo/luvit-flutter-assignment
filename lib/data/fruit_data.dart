import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Fruit {
  final int age;
  final String description;
  final List images;
  final int likeCount;
  final String location;
  final String name;
  final List tags;

  Fruit({
    required this.age,
    required this.description,
    required this.images,
    required this.likeCount,
    required this.location,
    required this.name,
    required this.tags
  });

  factory Fruit.fromMap(Map<dynamic, dynamic> map) {
    return Fruit(
      age: map['age'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      images: map['images'] ?? '',
      likeCount: map['likeCount'] ?? '',
      location: map['location'] ?? '',
      tags: map['tags'] ?? '',
    );
  }


}


