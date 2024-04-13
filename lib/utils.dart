import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Example event class.
class Event {
  final String title;
  final String description;

  const Event(this.title, this.description);
}
