import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/drawer_widget.dart';
import 'package:worker_tasks_app/widgets/worker_details_widget.dart';
import 'package:worker_tasks_app/widgets/worker_widget.dart';

import '../../constants.dart';
import '../../widgets/task_widget.dart';

class AllWorkersScreen extends StatefulWidget {
  AllWorkersScreen({super.key});
  static String id = 'allworkesScreen';

  @override
  State<AllWorkersScreen> createState() => _AllWorkersScreenState();
}

class _AllWorkersScreenState extends State<AllWorkersScreen> {
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
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'All Workers',
            style: TextStyle(color: Colors.pink.shade800),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.pink.shade800,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data =
                          documents[index].data() as Map<String, dynamic>;
                      return WorkerWidget(
                        //or  userUid: snapshot.data!.docs[index]['id'],
                        userUid: data['id'],
                        email: data['email'],
                        name: data['name'],
                        des: '${data['pos']} / ${data['phoneNum']}',
                        imageUrl: data['userImageUrl'],
                        icon: Icon(
                          Icons.mail_outlined,
                          size: 30.0,
                          color: Colors.pink.shade800,
                        ),
                      );
                    });
              }
            }
            return Center(
              child: Text('Something Went Wrong'),
            );
          },
        ));
  }
}
