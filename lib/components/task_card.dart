import 'package:flutter/material.dart';


class TaskCard extends StatefulWidget {



  final Map<String, dynamic> task;

  TaskCard({required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Color getCompletionColor(bool isOverdue, bool isComplete){
    if (isOverdue == true && isComplete == false){
      return Colors.red;
    }else if (isOverdue == false && isComplete == false){
      return Colors.grey;
    }else{
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Priority color
    Color priorityColor;
    switch (widget.task['priority']) {
      case 'High':
        priorityColor = Colors.red;
        break;
      case 'Medium':
        priorityColor = Colors.orange;
        break;
      case 'Low':
        priorityColor = Colors.green;
        break;
      default:
        priorityColor = Colors.blue;
    }

    // Due date logic
    DateTime dueDate = DateTime.parse(widget.task['dueDate']!);
    DateTime today = DateTime.now();
    bool isOverdue = dueDate.isBefore(today);
    bool isComplete = widget.task['completed']!;
    String formattedDate = '${dueDate.day}/${dueDate.month}/${dueDate.year}';

    return GestureDetector(
      onTap: () {
        // Open task details
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 12),
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          leading: Icon(Icons.task, color: priorityColor),
          title: Text(
            widget.task['title']!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task['description']!,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(height: 8),
              // Display Due Date with Badge
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                decoration: BoxDecoration(
                  color: isOverdue ? Colors.red : Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isOverdue ? 'Overdue' : 'Due: $formattedDate',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.check_circle,
              color: getCompletionColor(isOverdue, isComplete)
              
              //isOverdue ? Colors.grey : Colors.green,
            ),
            onPressed: () {
              // Handle task completion
              
               setState(() {
                    widget.task['completed'] = !widget.task['completed']!;
                              }); 
                //return TaskCard(widget.task);
             // widget.onToggle();
            },
          ),
        ),
      ),
    );
  }
}