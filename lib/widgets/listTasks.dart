import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m12calendar_flutter/authController.dart';
import 'editTasks.dart';
// Import your Event class

class EventListWidget extends StatelessWidget {
  final ValueListenable<List<Event>> selectedEvents;
  final DateTime date;

  EventListWidget({required this.selectedEvents, required this.date});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<Event>>(
        valueListenable: selectedEvents,
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromARGB(255, 205, 215, 223),
                  ),
                  child: ListTile(
                    title: Text('${value[index].title}'),
                    subtitle: Text('${value[index].description}'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return EditTaskDialog(
                            initialTitle: value[index].title,
                            initialDescription: value[index].description,
                            initialDate: date,
                            onUpdate:
                                (initialTitle, newDescription, initialDate) {
                              // Handle the updated task details
                              // Update your data structure or make an API call to save the changes
                              updateTask(
                                  initialTitle, newDescription, initialDate);
                            },
                            onDelete: (initialTitle, initialDate) {
                              // Handle the deletion of the task
                              // Update your data structure or make an API call to delete the task
                              deleteTask(initialTitle, initialDate);
                            },
                          );
                        },
                      );
                    },
                  ));
            },
          );
        },
      ),
    );
  }
}
