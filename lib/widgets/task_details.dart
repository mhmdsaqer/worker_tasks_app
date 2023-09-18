import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:worker_tasks_app/widgets/comment_widget.dart';
import 'package:worker_tasks_app/widgets/custem_materialbutton.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';

class TaskDetailsWidget extends StatefulWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  static String id = 'taskDetailsWidget';
  final String? userUploded;
  final String? taskid;

  TaskDetailsWidget(
      {super.key, @required this.taskid, @required this.userUploded});

  @override
  State<TaskDetailsWidget> createState() => _TaskDetailsWidgetState();
}

class _TaskDetailsWidgetState extends State<TaskDetailsWidget> {
  bool? isLoding = false;
  bool? isDone = false;
  String? taskTitle = '';
  String? taskDescription = '';
  String? userImageUrl;
  String? userPos = '';
  String? userName = '';
  Timestamp? uploadedOnTimeStamp;
  Timestamp? deadlineDateTimeStamp;
  String? deadlineDate = '';
  String? postedDate = '';
  String? commenterName = '';
  String? commenterImageUrl = '';
  bool? isDeadline_ok = false;
  bool? canChange = false;
  TextEditingController? _commentController = TextEditingController();
  List<String> taskComments = [];
  Future<void> getTaskData() async {
    isLoding = true;
    try {
      final DocumentSnapshot<dynamic> taskDoc = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskid)
          .get();
      if (taskDoc == null) {
        return;
      } else {
        setState(() {
          taskTitle = taskDoc.get('taskTitle');
          taskDescription = taskDoc.get('taskDescription');
          uploadedOnTimeStamp = taskDoc.get('createdAt');
          var uploded = uploadedOnTimeStamp!.toDate();
          postedDate = '${uploded.day}-${uploded.month}-${uploded.year}';
          deadlineDate = taskDoc.get('deadlineDate');
          deadlineDateTimeStamp = taskDoc.get('deadlinedateTimestamp');
          isDone = taskDoc.get('isDone');
          var date = deadlineDateTimeStamp!.toDate();
          isDeadline_ok = date.isAfter(DateTime.now());
        });
      }

      final DocumentSnapshot<dynamic> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('${widget.userUploded}')
          .get();
      setState(() {
        userName = userDoc.get('name');
        userPos = userDoc.get('pos');
        userImageUrl = userDoc.get('userImageUrl');
      });
      final DocumentSnapshot<dynamic> commenterDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc('${widget._auth.currentUser!.uid}')
          .get();
      setState(() {
        commenterName = commenterDoc.get('name');
        commenterImageUrl = commenterDoc.get('userImageUrl');
      });
    } catch (ex) {
      print('$ex');
    } finally {
      setState(() {
        isLoding = false;
      });
    }
  }

  @override
  void dispose() {
    _commentController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getTaskData();
  }

  bool isComment = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              taskTitle!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uploaded by',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 3, color: Colors.pink.shade800),
                                  image: DecorationImage(
                                      image: userImageUrl == null
                                          ? NetworkImage(
                                              'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg')
                                          : NetworkImage(userImageUrl!))),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userName!,
                                  style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  userPos!,
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Uploaded on :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(postedDate!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Deadline date :',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deadlineDate!,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: isDeadline_ok!
                          ? Text(
                              'Still have time',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )
                          : Text(
                              'Ended',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Done state :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isDone = !isDone!;
                            });
                          },
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  canChange = isCanChange(widget.userUploded!,
                                      widget._auth.currentUser!.uid);
                                  if (canChange!) {
                                    FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(widget.taskid)
                                        .update({
                                      'isDone': true,
                                    });
                                    getTaskData();
                                  } else {
                                    var snakBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'You cant change it ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snakBar);
                                  }
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      decoration: isDone!
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      color: Colors.blue),
                                ),
                              ),
                              Opacity(
                                  opacity: isDone! ? 1 : 0,
                                  child: Icon(Icons.check_box_sharp,
                                      color: Colors.green))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isDone = !isDone!;
                            });
                          },
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  canChange = isCanChange(widget.userUploded!,
                                      widget._auth.currentUser!.uid);
                                  if (canChange!) {
                                    FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(widget.taskid)
                                        .update({
                                      'isDone': false,
                                    });
                                    getTaskData();
                                  } else {
                                    var snakBar = SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'You cant change it ',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snakBar);
                                  }
                                },
                                child: Text(
                                  'Not Done Yet',
                                  style: TextStyle(
                                      decoration: !isDone!
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      color: Colors.blue),
                                ),
                              ),
                              Opacity(
                                  opacity: !isDone! ? 1 : 0,
                                  child: Icon(Icons.check_box_sharp,
                                      color: Colors.red))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Task description :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      taskDescription!,
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: isComment!
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                  Flexible(
                                    flex: 3,
                                    child: TextField(
                                      controller: _commentController,
                                      keyboardType: TextInputType.text,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                      maxLength: 200,
                                      maxLines: 7,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Column(
                                        children: [
                                          CustemMaterialButton(
                                            textColor: Colors.white,
                                            buttonColor: Colors.pink.shade800,
                                            text: 'Post',
                                            onPressed: () async {
                                              if (_commentController!
                                                      .text.length >
                                                  7) {
                                                var commentID = Uuid().v4();
                                                await FirebaseFirestore.instance
                                                    .collection('tasks')
                                                    .doc(widget.taskid)
                                                    .update({
                                                  'taskComments':
                                                      FieldValue.arrayUnion([
                                                    {
                                                      'commenterId': widget
                                                          ._auth
                                                          .currentUser!
                                                          .uid,
                                                      'commentId': commentID,
                                                      'name': commenterName,
                                                      'commentBoby':
                                                          _commentController!
                                                              .text,
                                                      'time': Timestamp.now(),
                                                      'commenterImageUrl':
                                                          commenterImageUrl,
                                                    }
                                                  ])
                                                });
                                                _commentController!.clear();
                                                var snakBar = await SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text(
                                                    'Succssesfully added ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snakBar);
                                              } else {
                                                var snakBar = await SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text(
                                                    'Please enter more than 7 letters ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snakBar);
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          CustemMaterialButton(
                                              textColor: Colors.pink.shade800,
                                              buttonColor: Colors.white,
                                              text: 'Cancel',
                                              onPressed: () {
                                                setState(() {
                                                  isComment = !isComment;
                                                });
                                              }),
                                        ],
                                      ),
                                    ),
                                  )
                                ])
                          : Align(
                              alignment: Alignment.center,
                              child: CustemMaterialButton(
                                  text: 'Add a comment',
                                  textColor: Colors.white,
                                  buttonColor: Colors.pink.shade800,
                                  onPressed: () {
                                    setState(() {
                                      isComment = true;
                                    });
                                  }),
                            ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(widget.taskid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.pink.shade800,
                          ));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var taskData = snapshot.data!.data();

                          int itemCount = taskData!['taskComments'].length;

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CommentWidget(
                                commentAll: taskData!['taskComments'][index],
                                taskId: widget.taskid,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(thickness: 1);
                            },
                            itemCount: itemCount,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isCanChange(String uplodedId, String currentId) {
    return uplodedId == currentId;
  }
}
