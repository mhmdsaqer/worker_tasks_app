import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/comment_widget.dart';
import 'package:worker_tasks_app/widgets/custem_materialbutton.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';

class TaskDetailsWidget extends StatefulWidget {
  static String id = 'taskDetailsWidget';

  TaskDetailsWidget({super.key});

  @override
  State<TaskDetailsWidget> createState() => _TaskDetailsWidgetState();
}

class _TaskDetailsWidgetState extends State<TaskDetailsWidget> {
  bool isComment = false;
  bool isDone = false;
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
              'Task Title',
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
                                      width: 5, color: Colors.pink.shade800),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1985&q=80'))),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Worker name',
                                  style: TextStyle(
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Worker Pos',
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
                        Text('8-7-2021'),
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
                          '8-7-2021',
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
                      child: Text(
                        'Still have time',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
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
                              isDone = !isDone;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'Done',
                                style: TextStyle(
                                    decoration: isDone
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    color: Colors.blue),
                              ),
                              Opacity(
                                  opacity: isDone ? 1 : 0,
                                  child: Icon(Icons.check_box_sharp,
                                      color: Colors.green))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isDone = !isDone;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                'Not Done Yet',
                                style: TextStyle(
                                    decoration: !isDone
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    color: Colors.blue),
                              ),
                              Opacity(
                                  opacity: !isDone ? 1 : 0,
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
                      'Des',
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
                                              onPressed: () {}),
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
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CommentWidget();
                        },
                        separatorBuilder: (context, index) {
                          return Divider(thickness: 1);
                        },
                        itemCount: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
