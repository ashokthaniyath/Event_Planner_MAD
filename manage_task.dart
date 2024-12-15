import 'package:flutter/material.dart';

class ManageTask extends StatefulWidget {
  const ManageTask({super.key});

  @override
  State<ManageTask> createState() => _ManageTaskState();
}

class _ManageTaskState extends State<ManageTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage the Task',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: Row(
        children: [
          Text('Budget'),


        ],
      ),
    );
  }
}
