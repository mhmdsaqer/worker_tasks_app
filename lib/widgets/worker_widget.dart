import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:worker_tasks_app/widgets/task_details.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';
import 'package:worker_tasks_app/constants.dart';

class WorkerWidget extends StatefulWidget {
  WorkerWidget({
    @required this.name,
    this.ontap,
    @required this.des,
    @required this.imageUrl,
    @required this.icon,
    this.userUid,
    this.email,
    super.key,
  });
  String? userUid;
  String? imageUrl;
  String? name;
  String? des;
  String? email;
  Icon? icon;
  Function? ontap;
  @override
  State<WorkerWidget> createState() => _WorkerWidgetState();
}

class _WorkerWidgetState extends State<WorkerWidget> {
  @override
  Widget build(BuildContext context) {
    constColors.shuffle();
    return Card(
      elevation: 0.8,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WorkerDetailsWidget(
                  userId: widget.userUid,
                );
              })),
          onLongPress: () {},
          leading: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4, color: constColors[0]),
                image: DecorationImage(
                    image: widget.imageUrl == null
                        ? NetworkImage(
                            'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg')
                        : NetworkImage(widget.imageUrl!))),
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
          trailing: IconButton(
              onPressed: () {
                launchUrl(Uri.parse('mailto:${widget.email}'));
              },
              icon: widget.icon!)),
    );
  }
}
