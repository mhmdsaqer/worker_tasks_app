import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';
import 'package:worker_tasks_app/widgets/worker_widget.dart';

class CommentWidget extends StatefulWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CommentWidget({super.key, this.commentAll, this.taskId});
  dynamic? commentAll;
  String? taskId;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    constColors.shuffle();
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WorkerDetailsWidget(
            userId: widget.commentAll['commenterId'],
          );
        }));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: () async {
                    if (widget._auth.currentUser!.uid ==
                        widget.commentAll['commenterId']) {
                      setState(() {
                        deleteComment(
                            widget.taskId!, widget.commentAll['commentId']);
                      });

                      Navigator.pop(context);
                    } else {
                      Navigator.pop(context);
                      var snakBar = SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'You cant delete this comment ',
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 3, color: constColors[0]),
                image: DecorationImage(
                    image: widget.commentAll['commenterImageUrl'] == null
                        ? NetworkImage(
                            'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg')
                        : NetworkImage(
                            widget.commentAll['commenterImageUrl']))),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.commentAll['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                widget.commentAll['commentBoby'],
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }

  void deleteComment(String taskId, String commentId) async {
    final taskReference =
        FirebaseFirestore.instance.collection('tasks').doc(taskId);

    try {
      // Get the current document containing the 'taskComments' array
      final taskSnapshot = await taskReference.get();

      if (taskSnapshot.exists) {
        // Extract the 'taskComments' array
        final List<dynamic> taskComments = taskSnapshot.get('taskComments');

        // Find the index of the comment with the specified commentId
        final int commentIndex = taskComments
            .indexWhere((comment) => comment['commentId'] == commentId);

        if (commentIndex != -1) {
          // Remove the comment from the array
          taskComments.removeAt(commentIndex);

          // Update the document with the modified 'taskComments' array
          await taskReference.update({'taskComments': taskComments});
        } else {
          print('Comment with commentId $commentId not found.');
        }
      } else {
        print('Task document with taskId $taskId does not exist.');
      }
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }
}
