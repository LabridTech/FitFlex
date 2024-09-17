import 'package:app/models/customermodal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/models/response.dart';
import 'dart:developer';
import 'firebase_options.dart';
import './data/excersise.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class FirebaseCrud {
//CRUD method here

  void removeSessionvariable() async {
    await SessionManager().remove("email");
    await SessionManager().remove("password");
    await SessionManager().remove("trainer");
  }

  void setSessionvariable(String email, String password) async {
    if (await SessionManager().containsKey('email') == false) {
      //print(email);
      await SessionManager().set("email", email);
      await SessionManager().set("password", password);
      await SessionManager().set("trainer", 'no');
    }
  }

  Future<bool> gettrainertype() async {
    String trainertype = await SessionManager().get("trainer");
    print(trainertype);
    if (trainertype == 'no') {
      return false;
    }
    return true;
  }

  Future<void> settrainertype() async {
    String trainertype = await SessionManager().get("trainer");
    await SessionManager().remove("trainer");
    if (trainertype == 'no') {
      await SessionManager().set("trainer", 'yes');
    } else {
      await SessionManager().set("trainer", 'no');
    }
  }

  Future<void> addUser(name, email, password) async {
    setSessionvariable(email, password);
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference users = db.collection('Customers');
    return await users
        .add({
          'Name': name,
          'Email': email,
          'Password': password,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addtrainer(role, locate, trianees, exp, workingHours) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    dynamic email = await SessionManager().get("email");
    final CollectionReference users = db.collection('Trainers');
    return await users
        .add({
          'Email': email,
          'Trainer Role': role,
          'Location': locate,
          'Trainees': trianees,
          'Experience': exp,
          'WorkingHours': workingHours,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<Map<String, dynamic>> readtrainer(email) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Trainers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();
    if (snapshot.docs.isEmpty) {
      return {
        'Trainer Role': 'Trainer',
        'Location': 'Islamabad',
        'Trainees': '5000+',
        'Experience': '5+',
        'WorkingHours': {
          'Monday': '00:00-00:00',
          'Tuesday': '00:00-00:00',
          'Wednesday': '00:00-00:00',
          'Thursday': '00:00-00:00',
          'Friday': '00:00-00:00',
          'Saturday': '00:00-00:00',
          'Sunday': '00:00-00:00',
        }
      };
    }
    print(snapshot.docs.first.data());
    return {
      'Trainer Role': snapshot.docs.first.data()['Trainer Role'].toString(),
      'Location': snapshot.docs.first.data()['Location'].toString(),
      'Trainees': snapshot.docs.first.data()['Trainees'].toString(),
      'Experience': snapshot.docs.first.data()['Experience'].toString(),
      'WorkingHours': {
        'Monday':
            snapshot.docs.first.data()['WorkingHours']['Monday'].toString(),
        'Tuesday':
            snapshot.docs.first.data()['WorkingHours']['Tuesday'].toString(),
        'Wednesday':
            snapshot.docs.first.data()['WorkingHours']['Wednesday'].toString(),
        'Thursday':
            snapshot.docs.first.data()['WorkingHours']['Thursday'].toString(),
        'Friday':
            snapshot.docs.first.data()['WorkingHours']['Friday'].toString(),
        'Saturday':
            snapshot.docs.first.data()['WorkingHours']['Saturday'].toString(),
        'Sunday':
            snapshot.docs.first.data()['WorkingHours']['Sunday'].toString(),
      },
    };
  }

  Future<Customer> readCustomer() async {
    dynamic email = await SessionManager().get("email");
    log('$email in firebase');
    await Future.delayed(const Duration(seconds: 10));
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Customers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();

    dynamic password = await SessionManager().get("password");
    print('$password infun');
    print('${snapshot.docs.first.data()['meal']} infun');
    if (password != snapshot.docs.first.data()['Password'].toString()) {
      await SessionManager().remove("email");
      await SessionManager().remove("password");
      return const Customer(
          id: '',
          name: '',
          meal: '',
          workout: '',
          email: 'wrong password',
          password: '',
          age: 1,
          height: 1,
          weight: 1,
          gender: Gender.male);
    }

    Map<String, dynamic> docsnap = snapshot.docs.first.data();
    return Customer(
      id: snapshot.docs.first.id,
      name: docsnap['Name'].toString(),
      email: docsnap['Email'].toString(),
      password: docsnap['Password'].toString(),
      age: int.parse(docsnap['Age'].toString()),
      height: int.parse(docsnap['Height'].toString()),
      weight: int.parse(docsnap['Weight'].toString()),
      workout: docsnap['workout'].toString(),
      meal: docsnap['meal'].toString(),
      gender: docsnap['Gender'].toString() == 'M' ? Gender.male : Gender.female,
    );
  }

  Future<void> updateCustomer(email, age, weight, height, gender) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    //log(email);
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Customers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();

    //log(snapshot.docs.first.id);

    String docname = snapshot.docs.first.id;
    await db
        .collection('Customers')
        .doc(docname)
        .update({
          'Height': int.parse(height.toString()),
          'Weight': int.parse(weight.toString()),
          'Age': int.parse(age.toString()),
          'Gender': gender.toString(),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<Map<String, dynamic>?> getexsercise() async {
    dynamic email = await SessionManager().get("email");
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Customers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();
    Map<String, dynamic> docsnap = snapshot.docs.first.data();

    DocumentSnapshot<Map<String, dynamic>> plansnapshot =
        await db.collection('Plans').doc(docsnap['workout'].toString()).get();
    Map<String, dynamic>? plandocsnap = plansnapshot.data();
    plandocsnap ??= {'error': 'no workout'};
    print(plandocsnap);
    return plandocsnap;
  }

  Future<Map<String, dynamic>?> getfood() async {
    dynamic email = await SessionManager().get("email");
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Customers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();
    Map<String, dynamic> docsnap = snapshot.docs.first.data();
    print(docsnap);
    DocumentSnapshot<Map<String, dynamic>> plansnapshot =
        await db.collection('Meals').doc(docsnap['meal'].toString()).get();
    Map<String, dynamic>? plandocsnap = plansnapshot.data();
    plandocsnap ??= {'error': 'no workout'};
    print(plandocsnap);
    return plandocsnap;
  }

  Future<List<Map<String, dynamic>>> getplans() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Plans').get();
    List<Map<String, dynamic>> plans = [];
    var plan;
    for (plan in snapshot.docs.toList()) {
      print(plan.data());
      plans.add(plan.data());
    }
    return plans;
  }

  Future<List<Map<String, dynamic>>> getmeals() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Meals').get();
    List<Map<String, dynamic>> plans = [];
    var plan;
    for (plan in snapshot.docs.toList()) {
      print(plan.data());
      plans.add(plan.data());
    }
    return plans;
  }

  Future<void> addmeal(
      name, plananme, price, abs, chest, lower, abss, chests, lowers) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    dynamic email = await SessionManager().get("email");
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Plans').get();
    int id = int.parse(snapshot.docs.last.data()['id'].toString());

    await db.collection('Meals').add({
      'email': email,
      'id': id,
      'name': name,
      'Planname': plananme,
      'Price': price,
      'break': abs,
      'lunch': chest,
      'dinner': lower,
      'breaks': abss,
      'lunchs': chests,
      'dinners': lowers,
    });
  }

  Future<void> addplan(
      name, plananme, price, abs, chest, lower, abss, chests, lowers) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    dynamic email = await SessionManager().get("email");
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('Plans').get();
    int id = int.parse(snapshot.docs.last.data()['id'].toString());

    await db.collection('Plans').add({
      'email': email,
      'id': id,
      'name': name,
      'Planname': plananme,
      'Price': price,
      'exc_abs': abs,
      'exc_chest': chest,
      'exc_lower': lower,
      'excs_abs': abss,
      'excs_chest': chests,
      'excs_lower': lowers,
    });
  }

  Future<Map<String, dynamic>> buyplan(id) async {
    Map<String, dynamic> message = {};
    final FirebaseFirestore db = FirebaseFirestore.instance;
    dynamic email = await SessionManager().get("email");
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Customers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();

    //log(snapshot.docs.first.id);

    String docname = snapshot.docs.first.id;
    //log(email);
    QuerySnapshot<Map<String, dynamic>> snapshot2 = await db
        .collection('Plans')
        .where(
          'id',
          isEqualTo: id,
        )
        .get();

    String docid = snapshot2.docs.first.id;
    print(docname + ' hello');
    print(docid);
    await db
        .collection('Customers')
        .doc(docname)
        .update({
          'workout': docid,
        })
        .then((value) => {
              message.addAll({'msg': 'success'})
            })
        .catchError((error) => {
              message.addAll({'msg': 'success'})
            });
    print(message);
    return message;
  }

  Future<Map<String, dynamic>> buymeal(id) async {
    Map<String, dynamic> message = {};
    final FirebaseFirestore db = FirebaseFirestore.instance;
    dynamic email = await SessionManager().get("email");
    QuerySnapshot<Map<String, dynamic>> snapshot = await db
        .collection('Customers')
        .where(
          'Email',
          isEqualTo: email,
        )
        .get();

    //log(snapshot.docs.first.id);

    String docname = snapshot.docs.first.id;
    //log(email);
    QuerySnapshot<Map<String, dynamic>> snapshot2 = await db
        .collection('Meals')
        .where(
          'id',
          isEqualTo: id,
        )
        .get();

    String docid = snapshot2.docs.first.id;
    print(docname + ' hello');
    print(docid);
    await db
        .collection('Customers')
        .doc(docname)
        .update({
          'meal': docid,
        })
        .then((value) => {
              message.addAll({'msg': 'success'})
            })
        .catchError((error) => {
              message.addAll({'msg': 'success'})
            });
    print(message);
    return message;
  }
}
