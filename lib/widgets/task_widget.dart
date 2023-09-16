import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/task_details.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({
    @required this.name,
    @required this.ontap,
    @required this.des,
    @required this.imageUrl,
    @required this.icon,
    this.isTask,
    super.key,
  });
  bool? isTask;
  String? imageUrl;
  String? name;
  String? des;
  Icon? icon;
  Function? ontap;

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
          onTap: widget.isTask!
              ? () => Navigator.pushNamed(context, TaskDetailsWidget.id)
              : () => Navigator.pushNamed(context, WorkerDetailsWidget.id),
          onLongPress: widget.isTask == true
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red),
                                Text('Delete',
                                    style: TextStyle(color: Colors.red))
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              : null,
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(width: 1),
              ),
            ),
            child: CircleAvatar(child: Image.network(widget.imageUrl!)),
          ),
          title: Text(
            widget.name!,
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
                widget.des!,
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
