import 'package:flutter/material.dart';

import 'models/todo.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoList(title: 'Flutter Todo'),

    );
  }
}


class TodoItem extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  TodoItem(
      {
        required this.todo,
        required this.onTodoChanged,
        required this.removeTodo,
        required this.updateTodo,

  }):super(key:ObjectKey(removeTodo));
   final Todo todo;
   final void Function(Todo todo) onTodoChanged;
   final void Function(Todo todo) removeTodo;
   final void Function(Todo todo) updateTodo;

   TextStyle? _getTextStyle(bool checked){
     if(!checked) return null;
     return const TextStyle(
       color:Colors.black54,
       decoration: TextDecoration.lineThrough,
     );
   }


   @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        onTodoChanged(todo);
      },
      leading:Checkbox(
        checkColor:Colors.green,
        activeColor: Colors.red,
        value:todo.completed,
        onChanged: (value){
          onTodoChanged(todo);
        },
      ),
      title:Row(
        children: <Widget>[
          Expanded(
            child:Text(todo.name,style:_getTextStyle(todo.completed))
          ),
          //Update icon
          IconButton(

              onPressed: (){
                //call the update Todo
                updateTodo(todo); // it accepts Todo type of argument of updation

              },
              icon:const Icon(Icons.edit)
          ),

          //Delete icon
          IconButton(
            iconSize: 30,
            icon:const Icon(
              Icons.delete,
              color:Colors.red,
            ),
            alignment: Alignment.centerRight,
            onPressed: (){
              removeTodo(todo);
            },
          )
        ],
      )
    );
  }

}

class TodoList extends StatefulWidget {
  const TodoList({super.key,required this.title});
 final String title;
  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = <Todo>[];
  final uuid = const Uuid();
  final TextEditingController _textEditingController = TextEditingController();
void _addTodoItem(String name){
  setState(() {
    String newId = uuid.v4(); // Generate unique id
    _todos.add(Todo(id:newId,name:name,completed: false));
  });
  _textEditingController.clear();
}
void _handleTodoChange(Todo todo){
  setState(() {
    todo.completed = !todo.completed;
  });
}

void _deleteTodo(Todo todo){
  setState(() {
    _todos.removeWhere((element) => element.name == todo.name);
  });
}
  void _updateTodo(Todo todo) {
    _textEditingController.text = todo.name;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText: 'Enter todo name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  todo.name = _textEditingController.text;

                });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.title)
      ),
      body:ListView(
        padding:const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((todo){
             return TodoItem(
               todo:todo,
               onTodoChanged: _handleTodoChange,
               removeTodo: _deleteTodo,
               updateTodo: _updateTodo,
             );
        }).toList(), // make iterable list
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>_displayDialog(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _displayDialog() async{
  return showDialog(
      context: context,
      barrierDismissible: false,  //  on tapping outside the dialog box , it won't close
      builder:(BuildContext context){
        return AlertDialog(
          title:const Text('Add a todo'),
          content:TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(hintText:'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
          style:OutlinedButton.styleFrom(
            shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
             )
            ),
        onPressed: (){
            Navigator.of(context).pop();
        },
        child:const Text('Cancel'),
            ),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),

                onPressed: (){
                _addTodoItem(_textEditingController.text);
                Navigator.of(context).pop();

                },
                child: const Text('Add'))

          ],

        );
      } );

  }



}


