import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m12calendar_flutter/utils.dart';

Future<void> userSetup() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({'email': auth.currentUser!.email});
  users.doc(uid).collection('tasks');
  return;
}

Future<List<Event>> getTasksForDay(DateTime day) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  CollectionReference eventCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(day.toString());

  final querySnapshot = await eventCollection.get();

  return querySnapshot.docs.map((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event(data['title'], data['description']);
  }).toList();
}

Future<void> addTask(String title, String description, String date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  CollectionReference tasks =
      FirebaseFirestore.instance.collection('users').doc(uid).collection(date);

  tasks.add({'title': title, 'description': description});
  return;
}

Future<Future<QuerySnapshot<Object?>>> getTasks(String date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  CollectionReference tasks =
      FirebaseFirestore.instance.collection('users').doc(uid).collection(date);
  return tasks.get();
}

Future<void> updateTask(String titleNew, String descriptionNew) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  // CollectionReference tasks = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(uid)
  // //     .collection(date);

  // // tasks.doc(docId).update({'title': titleNew, 'description': descriptionNew});
  return;
}
