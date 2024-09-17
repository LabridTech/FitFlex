import 'package:cloud_firestore/cloud_firestore.dart';

enum Gender {
  male,
  female,
}

class Customer {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.height,
    required this.weight,
    required this.workout,
    required this.meal,
    required this.gender,
  });

  final String id;
  final String name;
  final String email;
  final String password;
  final String workout;
  final String meal;
  final int age;
  final int weight;
  final int height;
  final Gender gender;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'age': age,
      'weight': weight,
      'height': height,
      'gender': gender.toString(),
      'workout': workout,
      'meal': meal,
    };
  }

  Customer.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!['id'].toString(),
        name = doc.data()!['Name'].toString(),
        email = doc.data()!['Email'].toString(),
        password = doc.data()!['Password'].toString(),
        age = int.parse(doc.data()!['Age'].toString()),
        height = int.parse(doc.data()!['Height'].toString()),
        weight = int.parse(doc.data()!['Weight'].toString()),
        workout = doc.data()!['workout'].toString(),
        meal = doc.data()!['meal'].toString(),
        gender = doc.data()!['Gender'].toString() == 'M'
            ? Gender.male
            : Gender.female;
}
