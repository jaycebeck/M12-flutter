import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Event {
  final String title;
  final String description;

  const Event(this.title, this.description);
}


Future<void> userSetup() async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  users.doc(uid).set({'email': auth.currentUser!.email});
  users.doc(uid).collection('tasks');
  return;
}

Future<List<Event>> getTasksForDay(DateTime date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  String formattedDate = date.toIso8601String().split('T')[0];

  CollectionReference eventCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(formattedDate);

  final querySnapshot = await eventCollection.get();

  return querySnapshot.docs.map((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Event(data['title'], data['description']);
  }).toList();
}

Future<void> addTask(String title, String description, DateTime date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid;

  // Use a combination of date and title as the document ID
  String formattedDate = date.toIso8601String().split('T')[0];

  // Reference to the tasks collection for the specific user and date
  CollectionReference tasks = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(formattedDate);

  // Set the task data with the specified document ID
  await tasks.doc(title).set({
    'title': title,
    'description': description,
  });
}

Future<Future<QuerySnapshot<Object?>>> getTasks(DateTime date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  String formattedDate = date.toIso8601String().split('T')[0];

  CollectionReference tasks = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(formattedDate);
  return tasks.get();
}

Future<void> updateTask(
    String title, String descriptionNew, DateTime date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  String formattedDate = date.toIso8601String().split('T')[0];

  CollectionReference tasks = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(formattedDate);

  tasks.doc(title).update({'description': descriptionNew});
  return;
}

Future<void> deleteTask(String title, DateTime date) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  String formattedDate = date.toIso8601String().split('T')[0];

  CollectionReference tasks = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection(formattedDate);

  tasks.doc(title).delete();
  return;
}
