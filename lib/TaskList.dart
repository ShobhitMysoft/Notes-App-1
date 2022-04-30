import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'database_helper.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final dbHelper = DatabaseHelper();
  var allTaskList = [];
  var allCompletedList = [];

  bool checked = false;

  void allTasks() async {
    final alllist = await dbHelper.queryAllTask();
    allTaskList = [];
    for (var taskObj in alllist) {
      allTaskList.add(taskObj['task']);
      allCompletedList.add(taskObj['completed']);
    }
  }

  @override
  Widget build(BuildContext context) {
    allTasks();
    return Expanded(
      child: ListView.builder(
          itemCount: allTaskList.length,
          itemBuilder: ((_, index) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('${allTaskList[index]}', 
              style: TextStyle(
                decoration: checked ? TextDecoration.lineThrough : TextDecoration.none
              ),),
              value: allCompletedList[index] == 1 ? true : false,
              onChanged: (bool? value) {
                isChecked(value, index);
                // setState(() {
                //   timeDilation = value! ? 6.0 : 1.0;
                // });
              },
              // selected: allCompletedList[index] == 1 ? true : false,
              secondary: const Icon(Icons.delete),
            );
          })),
    );
  }

  void isChecked(bool? checked, int index) {
    if (checked != null && checked) {
      setState(() {
        allCompletedList[index] = 1;
      });
      // update DB -> completed[1]
      print(allTaskList[index]);
    } else {
      setState(() {
        allCompletedList[index] = 0;
      });
    }
    print(allTaskList);
    print(allCompletedList);
  }
}
