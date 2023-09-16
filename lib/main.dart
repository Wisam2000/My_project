import 'package:untitled/add_task.dart';
import 'package:untitled/list_page.dart';
import 'package:untitled/task.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static List<Task> taskList = Task.generateData(0);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        TaskAddNewPage.routeName: (context) => TaskAddNewPage(
            title: "Add New Task", taskList: taskList),
        TaskListPage.routeName: (context) => TaskListPage(
            title: "Task List Page", taskList: taskList),
      },
    );
  }
}