import 'package:flutter/material.dart';
import 'package:worker_tasks_app/constants.dart';

Future<dynamic> selectJob(BuildContext context, TextEditingController job) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text('Close')),
        ],
        title: Text('Tasks Categorys'),
        content: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          //height: MediaQuery.of(context).size.height * 0.5,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      job.text = '${jobs[index]}';
                      Navigator.pop(context);
                    },
                    child: Text(
                      jobs[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }),
        ),
      );
    },
  );
}
