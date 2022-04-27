import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskList extends StatefulWidget {
  const TaskList({ Key? key }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> tasks = ['bread', 'milk', 'cheese', 'hummus', 'noodles'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int i) { 
          return ListTile(
            leading: Icon(Icons.check_box_outline_blank),
            title: Text(tasks[i]),
            trailing: Icon(Icons.delete),
            onTap: () {Fluttertoast.showToast(msg: 'You tapped ${tasks[i]}');},
          );
         },
      ),
    );
  }
}