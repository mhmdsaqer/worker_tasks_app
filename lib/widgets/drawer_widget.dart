import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/helper_methods/log_out_method.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/add_task_screen.dart';
import 'package:worker_tasks_app/screens/inner_screens/all_workers.dart';
import 'package:worker_tasks_app/widgets/inkwell_drawer_banners.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';

class DrawerWidget extends StatefulWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? userName = '';
  String? userPhoto =
      'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg';
  bool? isLoading = false;
  Color? myColor;
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final User? _auth = FirebaseAuth.instance.currentUser;

  Future<void> getUserData() async {
    constColors.shuffle();
    widget.isLoading = true;
    try {
      final DocumentSnapshot<dynamic> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget._auth.currentUser!.uid)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          widget.userPhoto = userDoc.get('userImageUrl');
          widget.userName = userDoc.get('name');
        });
      }
    } catch (ex) {
      print('$ex');
    } finally {
      setState(() {
        widget.isLoading = true;
      });
    }
  }

  @override
  initState() {
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          widget.isLoading!
              ? DrawerHeader(
                  decoration: BoxDecoration(color: constColors[0]),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 5,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            image: DecorationImage(
                                image: widget.userPhoto != widget.userPhoto
                                    ? NetworkImage(
                                        'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg')
                                    : NetworkImage(widget.userPhoto!))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          widget.userName == null
                              ? 'Workers Tasks App'
                              : widget.userName!,
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(color: Colors.pink.shade800),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return WorkerDetailsWidget(
                  userId: _auth!.uid,
                );
              }));
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
