import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/drawer_widget.dart';
import 'package:worker_tasks_app/widgets/task_details.dart';

import '../helper_methods/show_category.dart';
import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.pink.shade800),
          /*leading: Builder(
            builder: (ctx) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.pink.shade800,
                ),
              );
            },
          ),*/
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {
                showCategoriesMethod(context);
              },
              icon: Icon(
                Icons.filter_list,
                color: Colors.pink.shade800,
              ),
            )
          ],
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Tasks',
            style: TextStyle(color: Colors.pink.shade800),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade800,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data =
                        documents[index].data() as Map<String, dynamic>;
                    return TaskWidget(
                      userUploded: data['uploadedBy'],
                      taskID: data['taskId'],
                      taskTi: data['taskTitle'],
                      ontap: () {},
                      taskDes: data['taskDescription'],
                      isDone: data['isDone'],
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30.0,
                        color: Colors.pink.shade800,
                      ),
                    );
                  });
            }
            return Center(
              child: Text('there is no tasks'),
            );
          },
        )

        /* ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) {
          return TaskWidget(
            ontap: () {
              Navigator.pushNamed(ctx, TaskDetailsWidget.id);
            },
            imageUrl: 'https://cdn-icons-png.flaticon.com/512/4305/4305432.png',
            des: 'Task des',
            name: 'Task title',
            icon: Icon(
              Icons.keyboard_arrow_right,
              size: 30.0,
              color: Colors.pink.shade800,
            ),
            isTask: true,
          );
        },
      ),*/
        );
  }
}
