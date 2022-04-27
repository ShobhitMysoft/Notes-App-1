import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddTask.dart';
import 'package:flutter_application_1/TaskList.dart';

class MyHome extends StatelessWidget {
  const MyHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes App'),
      ),

      body: Column(
        children: [
          AddTask(),
          TaskList()
          // Expanded(
          //   child: ListView(
          //     children: [
          //       Text('Note 1'),
          //       Text('Note 1'),
          //       Text('Note 1'),
          //       Text('Note 1'),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}