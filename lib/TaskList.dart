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
  var allIDList = [];
  var allCompList = [];
  var allTaskList = [];

  Future<List<Map<String, dynamic>>> allTasks() async {
    final alllist = await dbHelper.queryAllTask();
    allIDList = [];
    allCompList = [];
    allTaskList = [];
    for (var taskObj in alllist) {
      allIDList.add(taskObj['id']);
      allCompList.add(taskObj['completed']);
      allTaskList.add(taskObj['task']);
    }
    return alllist;
  }

  @override
  Widget build(BuildContext context) {
    print(allTaskList);
    return Expanded(
      child: FutureBuilder(
        future: allTasks(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: allTaskList.length,
                    itemBuilder: ((_, index) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          '${allTaskList[index]}',
                          style: TextStyle(
                              color: allCompList[index] == 1
                                  ? Colors.grey : Colors.black),
                        ),
                        value: allCompList[index] == 1 ? true : false,
                        onChanged: (bool? value) {
                          isChecked(value, index);
                          // setState(() {
                          //   timeDilation = value! ? 6.0 : 1.0;
                          // });
                        },
                        secondary: IconButton(
                            onPressed: _delete(index),
                            icon: const Icon(Icons.heart_broken)),
                      );
                    }));
              } else {
                return Text('Result: ${snapshot.data}');
              }

            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text('Result: ${snapshot.data}');
          }
        },
      ),
    );
  }

  void isChecked(bool? checked, int index) {
    if (checked != null && checked) {
      Map<String, dynamic> row = {
        DatabaseHelper.colId: allIDList[index],
        DatabaseHelper.colCompleted: 1,
        DatabaseHelper.colTask: allTaskList[index]
      };

      setState(() {
        dbHelper.update(row);
        allCompList[index] = 1;
      });
      // update DB -> completed[1]
      print(allTaskList[index]);
    } else {
      Map<String, dynamic> row = {
        DatabaseHelper.colId: allIDList[index],
        DatabaseHelper.colCompleted: 0,
        DatabaseHelper.colTask: allTaskList[index]
      };

      setState(() {
        dbHelper.update(row);
        allCompList[index] = 0;
      });
    }
    print(allTaskList);
    print(allCompList);
  }

  _delete(int id) {
    dbHelper.delete(id);
  }
}
