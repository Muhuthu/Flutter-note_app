class ToDo {
  final String id;
  final String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
        id: '1',
        todoText: 'Learn Flutter',
        isDone: true,
      ),
      ToDo(
        id: '2',
        todoText: 'Learn Dart',
        isDone: false,
      ),
      ToDo(
        id: '3',
        todoText: 'Build Apps',
        isDone: false,
      ),
    ];
  }
}
