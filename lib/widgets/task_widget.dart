import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/task_details.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({
    @required this.taskDes,
    @required this.ontap,
    @required this.taskTi,
    @required this.icon,
    @required this.taskID,
    @required this.isDone,
    @required this.userUploded,
    super.key,
  });

  final String? _userId = FirebaseAuth.instance.currentUser!.uid;
  bool? isDone = false;

  String? taskTi;
  String? taskDes;
  Icon? icon;
  Function? ontap;
  String? taskID;
  String? userUploded;
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return TaskDetailsWidget(
                    taskid: widget.taskID,
                    userUploded: widget.userUploded,
                  );
                },
              ),
            );
            print(widget.taskID);
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (widget.userUploded == widget._userId) {
                          FirebaseFirestore.instance
                              .collection('tasks')
                              .doc(widget.taskID)
                              .delete();
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
                          var snakBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              'You cant delete this task ',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakBar);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          Text('Delete', style: TextStyle(color: Colors.red))
                        ],
                      ),
                    )
                  ],
                );
              },
            );
          },
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1),
              ),
            ),
            child: CircleAvatar(
                child: !widget.isDone!
                    ? Image.network(
                        'https://cdn-icons-png.flaticon.com/512/4305/4305432.png')
                    : Image.network(
                        'https://e7.pngegg.com/pngimages/270/706/png-clipart-check-mark-computer-icons-green-tick-mark-angle-text.png')),
          ),
          title: Text(
            widget.taskTi!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.linear_scale, color: Colors.pink.shade800),
              Text(
                widget.taskDes!,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
            ],
          ),
          trailing: widget.icon),
    );
  }
}
