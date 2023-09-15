import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/drawer_widget.dart';

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
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return TaskWidget(
                imageUrl:
                    'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1985&q=80',
                des: 'Worker pos / Phone num',
                name: 'Worker name',
                icon: Icon(
                  Icons.mail,
                  size: 30.0,
                  color: Colors.pink.shade800,
                ),
                isTask: false,
              );
            }));
  }
}
