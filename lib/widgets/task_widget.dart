import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.8,
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        onTap: () {},
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        Text('Delete', style: TextStyle(color: Colors.red))
                      ],
                    ),
                  )
                ],
              );
            },
          );
        },
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: CircleAvatar(
              child: Image.network(
                  'https://cdn-icons-png.flaticon.com/512/4305/4305432.png')),
        ),
        title: Text(
          'Tasks name',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.linear_scale, color: Colors.pink.shade800),
            Text(
              'Tasks des',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 30.0,
          color: Colors.pink.shade800,
        ),
      ),
    );
  }
}
