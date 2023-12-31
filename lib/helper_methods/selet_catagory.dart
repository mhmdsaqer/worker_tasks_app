import 'package:flutter/material.dart';

List<String> categores = [
  'Business',
  'Programming',
  'IT',
  'HR',
  'Marketing',
  'Design',
  'Accounting'
];
Future<dynamic> selectCatagory(
    BuildContext context, TextEditingController cat) {
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
              itemCount: categores.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      cat.text = '${categores[index]}';
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.check_circle_outline_outlined,
                            color: Colors.pink.shade800),
                        Text(
                          categores[index],
                          style: TextStyle(color: Colors.black),
                        )
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
