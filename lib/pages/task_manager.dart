import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/components/task_card.dart';

class TaskManagerPage extends StatefulWidget {
  @override
  _TaskManagerPageState createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Finish Design',
      'description': 'Complete UI design for app',
      'priority': 'High',
      'dueDate': '2025-10-12',
      'completed': false,
    },
    {
      'title': 'Meeting with Client',
      'description': 'Discuss project details',
      'priority': 'Medium',
      'dueDate': '2025-10-15',
      'completed': false,
    },
    {
      'title': 'Buy Groceries',
      'description': 'Get essentials from store',
      'priority': 'Low',
      'dueDate': '2025-10-10',
      'completed': false,
    },
  ];

  String _description = '';
  String _priority = 'Medium';
  DateTime _dueDate = DateTime.now();

  void addTask(String title) {
    if (title.isNotEmpty) {
      setState(() {
        tasks.add({
          'title': title,
          'description': _description.isEmpty ? 'New task added' : _description,
          'priority': _priority,
          'dueDate': _dueDate.toString().split(
            ' ',
          )[0], // Format as 'YYYY-MM-DD'
          'completed': false,
        });
        _taskController.clear();
        _description = '';
        _priority = 'Medium';
        _dueDate = DateTime.now();
      });
    }
  }

  Widget _buildStyledTextField(TextEditingController _taskController) {
    return TextField(
      controller: _taskController, // Attach the controller here
      decoration: InputDecoration(
        hintText: "Type something...",
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
        ),
        prefixIcon: Icon(Icons.message, color: Colors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(Icons.send, color: Colors.blueAccent),
          onPressed: () {
            // Handle send button press
            print("Text to send: ${_taskController.text}");
            // Optionally, clear the text after sending
            _taskController.clear();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do Manager',
          style: GoogleFonts.roboto(
            color: Colors.white,
          ), //TextStyle(color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF00B8D4),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Centered Task Input Field with Elevated Look
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),

              // child: _buildStyledTextField(_taskController)
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  hintText: 'Enter new task...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {}); // Update UI when typing
                },
              ),
            ),

            // Additional Fields when Task is Entered
            if (_taskController.text.isNotEmpty)
              Column(
                children: [
                  SizedBox(height: 20),
                  // Description Field
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        _description = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter description...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //SizedBox(height: 20),
                  // Priority Dropdown
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _priority,
                      items: ['High', 'Medium', 'Low']
                          .map(
                            (priority) => DropdownMenuItem<String>(
                              value: priority,
                              child: Text(priority),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _priority = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Due Date Picker
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: TextEditingController(
                        text: _dueDate.toLocal().toString().split(' ')[0],
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        border: InputBorder.none,
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _dueDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != _dueDate) {
                          setState(() {
                            _dueDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),

            SizedBox(height: 20),

            // Elevated Add Task Button
            ElevatedButton(
              onPressed: _taskController.text.isNotEmpty
                  ? () {
                      // setState(() {
                      //   // Reveal more fields
                      //   addTask(_taskController.text);
                      // });
                      //
                      addTask(_taskController.text);
                    }
                  : null,
              child: Text('Add Task'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00B8D4),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            // Task List Display
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  var task = tasks[index];
                  return TaskCard(
                    task: task,
                    // onToggle: (){
                    //   tasks[index]['completed'] = !tasks[index]['completed'];
                    // }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class TaskCard extends StatelessWidget {

//   final Map<String, dynamic> task;
//   final VoidCallback onToggle;

//   TaskCard({required this.task, required this.onToggle});

//   Color getCompletionColor(bool isOverdue, bool isComplete){
//     if (isOverdue == true && isComplete == false){
//       return Colors.red;
//     }else if (isOverdue == false && isComplete == false){
//       return Colors.grey;
//     }else{
//       return Colors.green;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Priority color
//     Color priorityColor;
//     switch (task['priority']) {
//       case 'High':
//         priorityColor = Colors.red;
//         break;
//       case 'Medium':
//         priorityColor = Colors.orange;
//         break;
//       case 'Low':
//         priorityColor = Colors.green;
//         break;
//       default:
//         priorityColor = Colors.blue;
//     }

//     // Due date logic
//     DateTime dueDate = DateTime.parse(task['dueDate']!);
//     DateTime today = DateTime.now();
//     bool isOverdue = dueDate.isBefore(today);
//     bool isComplete = task['completed']!;
//     String formattedDate = '${dueDate.day}/${dueDate.month}/${dueDate.year}';

//     return GestureDetector(
//       onTap: () {
//         // Open task details
//       },
//       child: Card(
//         margin: EdgeInsets.symmetric(vertical: 12),
//         elevation: 10,
//         shadowColor: Colors.black.withOpacity(0.1),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: ListTile(
//           contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//           leading: Icon(Icons.task, color: priorityColor),
//           title: Text(
//             task['title']!,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 task['description']!,
//                 style: TextStyle(color: Colors.black54),
//               ),
//               SizedBox(height: 8),
//               // Display Due Date with Badge
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
//                 decoration: BoxDecoration(
//                   color: isOverdue ? Colors.red : Colors.green,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   isOverdue ? 'Overdue' : 'Due: $formattedDate',
//                   style: TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.check_circle,
//               color: getCompletionColor(isOverdue, isComplete)

//               //isOverdue ? Colors.grey : Colors.green,
//             ),
//             onPressed: () {
//               // Handle task completion

//                // task['completed'] = !task['completed']!;
//               widget.onToggle();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
