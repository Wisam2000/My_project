class Task {
  late int _id;
  late String _name;
  late String _description;


  Task(
      {required int id,
        required String name,
        required String description,}) {
    setId = id;
    setName = name;
    setDescription = description;
  }
  int get getId {
    return _id;
  }

  set setId(int id) {
    _id = id;
  }

  String get getName {
    return _name;
  }

  set setName(String name) {
    _name =name;
  }

  String get getDescription {
    return _description;
  }

  set setDescription(String description) {
    _description = description;
  }

  static List<Task> generateData(int count) {
    List<Task> taskList = [];
    for (int i = 1; i <= count; i++) {
      taskList.add(
        Task(
          id: i,
          name: 'Task $i',
          description: '',
        ),
      );
    }
    return taskList;
  }

  void newName(String newName) {
    _name = newName;
  }
  void newDescription(String newDescription) {
    _description = newDescription;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': _name,
      'description': _description,
    };
  }
}