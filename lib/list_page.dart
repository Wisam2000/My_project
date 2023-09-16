import 'package:flutter/foundation.dart';
import 'package:untitled/task.dart';
import 'package:flutter/material.dart';
import 'add_task.dart';
import 'skldb.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TaskListPage extends StatefulWidget {
  static String routeName = "/";
  final String title;
  final List<Task> taskList;
  const TaskListPage({super.key, required this.title, required this.taskList});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String editedName = "";
  String editedDescription = "";



  TextEditingController textContrller = TextEditingController();

  SqlDb sqlDb = SqlDb();

  savePrefs(String txt) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Name", txt);
    print("success");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: widget.taskList.length,
        itemBuilder: (context, index) {
          final task = widget.taskList[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                if (direction == DismissDirection.startToEnd) {
                  widget.taskList.remove(task);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${task.getName} dismissed',
                        style: const TextStyle(
                          color: Colors.lightGreenAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'times',
                        ),
                      ),
                    ),
                  );
                } else {
                  editedName = task.getName;
                  editedDescription = task.getDescription;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Edit Task'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller:
                              TextEditingController(text: editedName),
                              onChanged: (newName) {
                                setState(() {
                                  editedName = newName;
                                });
                              },
                              decoration: InputDecoration(labelText: 'Name'),
                            ),
                            TextField(
                              controller: TextEditingController(
                                  text: editedDescription),
                              onChanged: (newDescription) {
                                setState(() {
                                  editedDescription = newDescription;
                                });
                              },
                              decoration:
                              InputDecoration(labelText: 'Description'),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                task.newName(editedName);
                                task.newDescription(editedDescription);
                              });
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            background: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Colors.red[900],
                  size: 50,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.blue[900],
                  size: 50,
                ),
              ],
            ),
            child: getTaskCard(task: task),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = Task(
            id: -1,
            name: "",
            description: "",
          );
          final result = await Navigator.pushNamed(
              context, TaskAddNewPage.routeName,
              arguments: newTask);
          setState(() {
            widget.taskList.add(result as Task);
          });
        },
        tooltip: 'Add new Task',
        child: const Icon(Icons.add),
      ),
      // Buttons added here
      persistentFooterButtons: [
        Container(
          color: Colors.grey,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Handle button press for "Insert Data"
                        // You can add your logic here
                      },
                      child: const Text("show data"),
                    ),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Handle button press for "Read Data"
                        // You can add your logic here
                      },
                      child: const Text("Read Data"),
                    ),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Handle button press for "Update Data"
                        // You can add your logic here
                      },
                      child: const Text("Update Data"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      onPressed: () async {
                        // Handle button press for "Delete Data"
                        // You can add your logic here
                      },
                      child: const Text("Delete Data"),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () async {await savePrefs('');},
                      child: const Text("Save Prefs"),
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: MaterialButton(
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {},
                      child: const Text("Go To second page"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget getTaskCard({required Task task}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
        side: const BorderSide(
          color: Color.fromARGB(250, 157, 7, 174),
          width: 3,
        ),
      ),
      elevation: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.task,
            size: 55,
            color: Colors.blue,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.getName, style: Theme.of(context).textTheme.headlineLarge,),
              SizedBox(width: MediaQuery.of(context).size.width / 1.5,
                child: Text(task.getDescription, style: Theme.of(context).textTheme.headlineSmall,),
              ),
            ],
          )
        ],
      ),
    );
  }
}
