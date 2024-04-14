// Adapted from Table Calendar Example Code

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:m12calendar_flutter/authController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/listTasks.dart';
import '../widgets/myAppBar.dart';

class TableCalendarPage extends StatefulWidget {
  @override
  _TableCalendarPageState createState() => _TableCalendarPageState();
}

class _TableCalendarPageState extends State<TableCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _eventsMap = {};
  TextEditingController _eventController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    // Initialize the ValueNotifier with an empty list
    _selectedEvents = ValueNotifier<List<Event>>([]);

    // Load the initial events for the current day (_selectedDay)
    fetchEventsForDay(_selectedDay!).then((_) {
      // Update the _selectedEvents with the fetched events
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  @override
  void dispose() {
    _eventController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _eventsMap[day] ?? [];
  }

  Future<void> fetchEventsForDay(DateTime day) async {
    final events = await getTasksForDay(day);
    setState(() {
      _eventsMap[day] = events;
    });

    // Update the ValueNotifier with the fetched events
    _selectedEvents.value = events;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      fetchEventsForDay(selectedDay).then((_) {
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(248, 0, 133, 102),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('Add a Task'),
                  content: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _eventController,
                          decoration: const InputDecoration(
                            hintText: 'Task Name',
                          ),
                        ),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Task Description',
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 20.0),
                            child: ElevatedButton(
                                onPressed: () async {
                                  // Add the task
                                  await addTask(
                                      _eventController.text,
                                      _descriptionController.text,
                                      _selectedDay!);

                                  // Update the selected events list
                                  _selectedEvents.value =
                                      await getTasksForDay(_selectedDay!);

                                  // Clear the text fields
                                  _eventController.clear();
                                  _descriptionController.clear();

                                  // Close the dialog
                                  Navigator.pop(context);
                                },
                                child: Text('Save')))
                      ],
                    ),
                  ),
                );
              });
        },
      ),
      body: Column(children: [
        TableCalendar(
            firstDay: DateTime.utc(2010, 2, 12),
            lastDay: DateTime.utc(2030, 3, 12),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              // Customize the decoration and text style for today
              todayDecoration: BoxDecoration(
                color: Colors.blueGrey, // Color for today
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(color: Colors.white),

              // Customize the decoration and text style for the selected day
              selectedDecoration: BoxDecoration(
                color:
                    Color.fromARGB(248, 0, 133, 102), // Color for selected day
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),

              // Customize the decoration and text style for default days
              defaultDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.black),

              // Customize the decoration and text style for days outside the focused month
              outsideDecoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              outsideTextStyle: TextStyle(color: Colors.grey),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )),
        const SizedBox(height: 8.0),
        EventListWidget(selectedEvents: _selectedEvents, date: _selectedDay!),
      ]),
    );
  }
}
