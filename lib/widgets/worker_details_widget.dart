import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:worker_tasks_app/helper_methods/log_out_method.dart';
import 'package:worker_tasks_app/screens/user_state.dart';
import 'package:worker_tasks_app/widgets/custem_materialbutton.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';

class WorkerDetailsWidget extends StatefulWidget {
  static String id = 'workerDetailsWidget';
  final String? userId;
  WorkerDetailsWidget({super.key, this.userId});

  @override
  State<WorkerDetailsWidget> createState() => _WorkerDetailsWidgetState();
}

class _WorkerDetailsWidgetState extends State<WorkerDetailsWidget> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool? isLoding = false;
  String? phoneNum = '';
  bool? isSameUser;
  String? email = '';
  String? imageUrl =
      'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg';
  String? name = '';
  String? job = '';
  String? joinedAt = '';
  Future<void> getUserData() async {
    isLoding = true;
    try {
      final DocumentSnapshot<dynamic> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          phoneNum = userDoc.get('phoneNum');
          imageUrl = userDoc.get('userImageUrl');
          name = userDoc.get('name');
          Timestamp joinedDate = userDoc.get('createdAt');
          final joined = joinedDate.toDate();
          joinedAt = '${joined.day}-${joined.month}-${joined.year}';
          job = userDoc.get('pos');
        });
        String? uid = _auth.currentUser!.uid;
        uid == widget.userId ? isSameUser = true : isSameUser = false;
      }
    } catch (ex) {
      print('$ex');
    } finally {
      setState(() {
        isLoding = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
      ),
      body: isLoding!
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.pink.shade800,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Stack(
                  children: [
                    Card(
                      margin: EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            name!,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '$job Since date : $joinedAt',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Content Info ',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Email: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        email!,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Phone Number: ',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        phoneNum!,
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  !isSameUser!
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                Uri url = Uri.parse(
                                                    'http://wa.me/$phoneNum?text=Hello');
                                                await launchUrl(url);
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.green,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.whatshot,
                                                      color: Colors.green,
                                                    )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                Uri url =
                                                    Uri.parse('mailto:$email');
                                                await launchUrl(url);
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.red,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.mail_outline,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                Uri url = Uri.parse(
                                                    'tel://$phoneNum');
                                                await launchUrl(url);
                                              },
                                              child: CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Colors.purple,
                                                child: CircleAvatar(
                                                    radius: 18,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.call,
                                                      color: Colors.purple,
                                                    )),
                                              ),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustemMaterialButton(
                                                text: 'Log out',
                                                buttonColor:
                                                    Colors.pink.shade800,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  logOutMethod(context);
                                                })
                                          ],
                                        ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 5,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                image: DecorationImage(
                                    image: imageUrl == null
                                        ? NetworkImage(
                                            'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg')
                                        : NetworkImage(imageUrl!))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
