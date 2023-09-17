import 'package:flutter/material.dart';
import 'package:worker_tasks_app/helper_methods/log_out_method.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/add_task_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/all_workers.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/widgets/inkwell_drawer_banners.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';

class DrawerWidget extends StatelessWidget {
  bool isMe = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image.network(
                        'https://images.unsplash.com/photo-1682685797229-b2930538da47?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Workers Tasks App',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
          ),
          DrawerInkWell(
            icon: Icons.task,
            ontap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.id);
            },
            text: 'All Tasks',
          ),
          DrawerInkWell(
            icon: Icons.settings,
            ontap: () {
              Navigator.pushNamed(
                context,
                WorkerDetailsWidget.id,
              );
            },
            text: 'My Account',
          ),
          DrawerInkWell(
            icon: Icons.work,
            ontap: () {
              Navigator.pushReplacementNamed(context, AllWorkersScreen.id);
            },
            text: 'Registerted Workers',
          ),
          DrawerInkWell(
            icon: Icons.add_task,
            ontap: () {
              Navigator.pushReplacementNamed(context, AddTaskScreen.id);
            },
            text: 'Add Task',
          ),
          Divider(
            thickness: 1,
          ),
          DrawerInkWell(
            icon: Icons.logout,
            ontap: () {
              logOutMethod(context);
            },
            text: 'Log out',
          ),
        ],
      ),
    );
  }
}
