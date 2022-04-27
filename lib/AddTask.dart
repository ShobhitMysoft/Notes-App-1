import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({ Key? key }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final value = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [

          // TextField
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a Task...',
                  labelText: 'Add Task',
                  contentPadding: EdgeInsets.only(left: 10, right: 10)
                ),
              ),
            ),
          ),

          // Button
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              width: 80,
              height: 40,
              child: ElevatedButton(onPressed: addTask, child: const Text('Add'))
              ),
          )
        ],
      ),
    );
  }

  addTask() {
    value.clear();
  }
}