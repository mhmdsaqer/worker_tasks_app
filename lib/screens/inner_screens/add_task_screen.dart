import 'package:flutter/material.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/helper_methods/submit_method.dart';
import 'package:worker_tasks_app/widgets/custem_button.dart';
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
                  CustemTextFormField(
                    Controller: _catagoryController,
                    hintString: 'Task Category',
                    filledd: true,
                    filledColor: Theme.of(context).scaffoldBackgroundColor,
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
                  CustemTextFormField(
                    Controller: _pickedDateController,
                    hintString: 'Pick Up a Date',
                    filledd: true,
                    filledColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CustemButton(
                        icon: Icon(Icons.upload),
                        text: 'Upload',
                        onPressed: () {
                          submitMethod(context, _addTaskKey);
                        }),
                  ),
                  SizedBox(
                    height: 50,
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
