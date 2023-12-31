import 'package:flutter/material.dart';

import '../constants.dart';

Future<dynamic> showCategoriesMethod(
    BuildContext context, Function getCat, Function getFil) {
  String? taskCat;
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
          TextButton(
              onPressed: () {
                getFil(false);
                Navigator.canPop(context) ? Navigator.pop(context) : null;
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
                      taskCat = categores[index];
                      getFil(true);
                      getCat(taskCat);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline_outlined,
                            color: Colors.pink.shade800),
                        Text(categores[index])
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    },
  );
}
