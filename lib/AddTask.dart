import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddTask extends StatefulWidget {
  const AddTask({ Key? key }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final value = TextEditingController();
  final dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0, bottom: 10.0),
      child: SizedBox(
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
      ),
    );
  }

  void addTask() async {
    
    Map<String, dynamic> row = {
      DatabaseHelper.colCompleted : 0,
      DatabaseHelper.colTask : 'asfsf'
    };
    
    final id = await dbHelper.insert(row);
    Fluttertoast.showToast(msg: 'inserted row id : $id');
    print('inserted row id : $id'); 


    final allRows = dbHelper.queryAllTask();
    Fluttertoast.showToast(msg: '$allRows');
    value.clear();
  }
}