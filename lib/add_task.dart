import 'package:untitled/skldb.dart';
import 'package:untitled/task.dart';
import 'package:flutter/material.dart';

class TaskAddNewPage extends StatefulWidget {
  static String routeName = "/addTask";
  final String title;
  final List<Task> taskList;
  const TaskAddNewPage(
      {super.key, required this.title, required this.taskList});

  @override
  State<TaskAddNewPage> createState() => _TaskAddNewPageState();
}

class _TaskAddNewPageState extends State<TaskAddNewPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isDescriptionValid = true;

  SqlDb sqlDb = SqlDb();

  @override
  Widget build(BuildContext context) {
    int newId = 0;
    for (var s in widget.taskList) {
      if (s.getId > newId) newId = s.getId;
    }
    newId += 1;
    final newTask = ModalRoute.of(context)!.settings.arguments as Task;
    newTask.setId = newId;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  enabled: false,
                  initialValue: newId.toString(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task id',
                    prefixIcon: Icon(Icons.numbers),
                  ),
                  /*
                  validator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return "Name is required!";
                    }
                    return null;
                  },
                   */
                  onSaved: (newValue) {
                    newTask.setId = int.parse(newValue!);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  controller: TextEditingController(text: newTask.getName),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Task title',
                    hintText: 'Type here Task title',
                    prefixIcon: Icon(Icons.task),
                  ),
                  onChanged: (newValue) {
                    newTask.setName = newValue;
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    labelText: 'Task Description',
                    prefixIcon: Icon(Icons.description),
                  ),
                  onChanged: (newValue) {
                    newTask.setDescription = newValue;
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            Navigator.pop(context, newTask);
            int response = await sqlDb.insertData("INSERT INTO tasks (name, description) VALUES ('TaskName', 'TaskDescription')");
            print(response);
          }
          //int response = await sqlDb.insertData("INSERT INTO tasks (id, name, description) VALUES ('TaskName', 'TaskDescription')");
          //print(response);
        },
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ),
    );
  }
}
//I made a new edit in Github
//hello world