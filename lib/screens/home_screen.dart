import 'package:flutter/material.dart';
import 'package:worker_tasks_app/widgets/drawer_widget.dart';

import '../widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static String id = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categores = [
    'Business',
    'Programming',
    'IT',
    'HR',
    'Marketing',
    'Design',
    'Accounting'
  ];

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
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                              },
                              child: Text('Close')),
                          TextButton(
                              onPressed: () {
                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : null;
                              },
                              child: Text('Cancel Filter'))
                        ],
                        title: Text('Tasks Categorys'),
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: categores.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: InkWell(
                                    onTap: () {
                                      //print('${categores[index]}');
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.pink.shade800),
                                        Text(categores[index])
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      );
                    });
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
        body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return TaskWidget();
            }));
  }
}
