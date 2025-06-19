// import 'package:flutter/material.dart';
// import '../models/app_models.dart';

// class TodoPage extends StatefulWidget {
//   const TodoPage({super.key});

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> with TickerProviderStateMixin {
//   final TodoModel todoModel = TodoModel();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
    
//     // Add some sample todos
//     todoModel.addTodo('Welcome to Todo App', 'This is your first todo item');
//     todoModel.addTodo('Learn Flutter Provider', 'Implement state management with Provider package');
//     todoModel.addTodo('Build Amazing Apps', 'Create beautiful and functional Flutter applications');
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todo Manager'),
//         backgroundColor: Colors.orange[600],
//         foregroundColor: Colors.white,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           tabs: [
//             Tab(text: 'All (${todoModel.totalTodos})'),
//             Tab(text: 'Pending (${todoModel.pendingTodos.length})'),
//             Tab(text: 'Completed (${todoModel.completedCount})'),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.delete_sweep),
//             onPressed: todoModel.completedTodos.isNotEmpty
//                 ? () {
//                     setState(() {
//                       todoModel.clearCompleted();
//                     });
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Completed todos cleared')),
//                     );
//                   }
//                 : null,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.orange[600]!, Colors.orange[400]!],
//               ),
//             ),
//             child: _buildProgressIndicator(),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 _buildTodoList(todoModel.todos),
//                 _buildTodoList(todoModel.pendingTodos),
//                 _buildTodoList(todoModel.completedTodos),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _showAddTodoDialog,
//         backgroundColor: Colors.orange[600],
//         icon: const Icon(Icons.add),
//         label: const Text('Add Todo'),
//       ),
//     );
//   }

//   Widget _buildProgressIndicator() {
//     final progress = todoModel.totalTodos > 0 
//         ? todoModel.completedCount / todoModel.totalTodos 
//         : 0.0;
    
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Progress',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '${(progress * 100).toInt()}%',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         LinearProgressIndicator(
//           value: progress,
//           backgroundColor: Colors.white.withOpacity(0.3),
//           valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildTodoList(List<Todo> todos) {
//     if (todos.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.inbox_outlined,
//               size: 64,
//               color: Colors.grey[400],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'No todos here',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(8),
//       itemCount: todos.length,
//       itemBuilder: (context, index) {
//         final todo = todos[index];
//         return Card(
//           margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//           child: ListTile(
//             leading: Checkbox(
//               value: todo.isCompleted,
//               onChanged: (_) {
//                 setState(() {
//                   todoModel.toggleTodo(todo.id);
//                 });
//               },
//               activeColor: Colors.orange[600],
//             ),
//             title: Text(
//               todo.title,
//               style: TextStyle(
//                 decoration: todo.isCompleted 
//                     ? TextDecoration.lineThrough 
//                     : TextDecoration.none,
//                 color: todo.isCompleted ? Colors.grey : Colors.black,
//               ),
//             ),
//             subtitle: Text(
//               todo.description,
//               style: TextStyle(
//                 color: todo.isCompleted ? Colors.grey : Colors.black54,
//               ),
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   _formatDate(todo.createdAt),
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () {
//                     setState(() {
//                       todoModel.deleteTodo(todo.id);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _formatDate(DateTime date) {
//     return '${date.day}/${date.month}';
//   }

//   void _showAddTodoDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Add New Todo'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: const InputDecoration(
//                 labelText: 'Title',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: _descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//               ),
//               maxLines: 3,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_titleController.text.isNotEmpty) {
//                 setState(() {
//                   todoModel.addTodo(
//                     _titleController.text,
//                     _descriptionController.text,
//                   );
//                 });
//                 _titleController.clear();
//                 _descriptionController.clear();
//                 Navigator.pop(context);
//               }
//             },
//             child: const Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }
// }