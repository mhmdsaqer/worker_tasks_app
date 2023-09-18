import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/helper_methods/selet_catagory.dart';
import 'package:worker_tasks_app/helper_methods/show_category.dart';
import 'package:worker_tasks_app/helper_methods/submit_method.dart';
import 'package:worker_tasks_app/widgets/custem_button.dart';
import 'package:worker_tasks_app/widgets/custem_materialbutton.dart';
import 'package:worker_tasks_app/widgets/custem_textformfield.dart';
import 'package:worker_tasks_app/widgets/drawer_widget.dart';

class AddTaskScreen extends StatefulWidget {
  static String id = 'addTask';
  AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _catagoryController = TextEditingController();
  TextEditingController _pickedDateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  bool isLoding = false;
  DateTime? picked;
  Timestamp? deadlineTimestamp;
  final _addTaskKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _catagoryController.dispose();
    _titleController.dispose();
    _desController.dispose();
    _pickedDateController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink.shade800),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Card(
            child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'All Fields are required',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Form(
              key: _addTaskKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task catagory*',
                    style: fieldNameStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      selectCatagory(context, _catagoryController);
                    },
                    child: CustemTextFormField(
                      black: true,
                      enabeld: true,
                      Controller: _catagoryController,
                      hintString: 'Task Category',
                      filledd: true,
                      filledColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Task title*',
                    style: fieldNameStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustemTextFormField(
                    black: true,
                    Controller: _titleController,
                    hintString: '',
                    filledd: true,
                    filledColor: Theme.of(context).scaffoldBackgroundColor,
                    maxLen: 100,
                  ),
                  Text(
                    'Task description*',
                    style: fieldNameStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustemTextFormField(
                    black: true,
                    Controller: _desController,
                    hintString: '',
                    filledd: true,
                    filledColor: Theme.of(context).scaffoldBackgroundColor,
                    maxLen: 1000,
                    maxLin: 5,
                  ),
                  Text(
                    'DeadLine date*',
                    style: fieldNameStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(Duration(days: 5)),
                          lastDate: DateTime(2030));
                      if (picked != null) {
                        deadlineTimestamp =
                            Timestamp.fromMicrosecondsSinceEpoch(
                                picked!.microsecondsSinceEpoch);
                        _pickedDateController.text = '${picked!.day} - '
                            '${picked!.month} - '
                            '${picked!.year}  ';
                      }
                    },
                    child: CustemTextFormField(
                      black: true,
                      enabeld: true,
                      Controller: _pickedDateController,
                      hintString: 'Pick Up a Date',
                      filledd: true,
                      filledColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !isLoding
                          ? CustemMaterialButton(
                              text: 'Upload',
                              buttonColor: Colors.pink.shade800,
                              textColor: Colors.white,
                              onPressed: () async {
                                bool isValid =
                                    submitMethod(context, _addTaskKey);
                                if (isValid) {
                                  setState(() {
                                    isLoding = true;
                                  });
                                  final taskId = Uuid().v4();
                                  String userId =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  await FirebaseFirestore.instance
                                      .collection('tasks')
                                      .doc('$taskId')
                                      .set({
                                    'taskId': taskId,
                                    'createdAt': Timestamp.now(),
                                    'uploadedBy': userId,
                                    'taskTitle': _titleController.text,
                                    'taskDescription': _desController.text,
                                    'deadlineDate': _pickedDateController.text,
                                    'deadlinedateTimestamp': deadlineTimestamp,
                                    'taskCategory': _catagoryController.text,
                                    'taskComments': [],
                                    'isDone': false,
                                  });
                                  setState(() {
                                    isLoding = false;

                                    _catagoryController.clear();
                                    _titleController.clear();
                                    _desController.clear();
                                    _pickedDateController.clear();
                                  });
                                  Fluttertoast.showToast(
                                      msg: "Task created sucssefully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      //gravity: ToastGravity.CENTER,
                                      //timeInSecForIosWeb: 1,
                                      // backgroundColor: Colors.green,
                                      //textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              })
                          : Center(
                              child: CircularProgressIndicator(
                                  color: Colors.pink.shade800),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
