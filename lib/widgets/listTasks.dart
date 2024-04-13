import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:m12calendar_flutter/authController.dart';
import '../utils.dart';
import 'editTasks.dart';
// Import your Event class

class EventListWidget extends StatelessWidget {
  final ValueListenable<List<Event>> selectedEvents;

  EventListWidget({required this.selectedEvents});

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
                            onUpdate: (newTitle, newDescription) {
                              // Handle the updated task details
                              // Update your data structure or make an API call to save the changes
                              updateTask(newTitle, newDescription);
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
