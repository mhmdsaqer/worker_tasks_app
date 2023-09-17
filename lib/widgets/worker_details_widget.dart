import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:worker_tasks_app/screens/user_state.dart';
import 'package:worker_tasks_app/widgets/custem_materialbutton.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';

class WorkerDetailsWidget extends StatefulWidget {
  static String id = 'workerDetailsWidget';

  WorkerDetailsWidget({super.key});

  @override
  State<WorkerDetailsWidget> createState() => _WorkerDetailsWidgetState();
}

class _WorkerDetailsWidgetState extends State<WorkerDetailsWidget> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool? isLoding = false;
  String? phoneNum = '';
  bool? isSameUser = true;
  String? email = '';
  String? imageUrl = '';
  String? name = '';
  String? job = '';
  String? joinedAt = '';
  Future<void> getUserData() async {
    isLoding = true;
    try {
      final DocumentSnapshot<dynamic> userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('zsBN8MfqKChJNVUXdnTJiiXfiLH3')
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
        // String? uid = _auth.currentUser!.uid;
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
      body: SingleChildScrollView(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      joinedAt!,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      decoration: TextDecoration.underline),
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
                                      decoration: TextDecoration.underline),
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
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.whatshot,
                                                color: Colors.green,
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Uri url = Uri.parse('mailto:$email');
                                          await launchUrl(url);
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.red,
                                          child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.mail_outline,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          Uri url =
                                              Uri.parse('tel://$phoneNum');
                                          await launchUrl(url);
                                        },
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.purple,
                                          child: CircleAvatar(
                                              radius: 18,
                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.call,
                                                color: Colors.purple,
                                              )),
                                        ),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustemMaterialButton(
                                          text: 'Log out',
                                          buttonColor: Colors.pink.shade800,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            _auth.signOut();
                                            Navigator.canPop(context)
                                                ? Navigator.pop(context)
                                                : null;
                                            Navigator.pushReplacementNamed(
                                                context, UserStateScreen.id);
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
                              color: Theme.of(context).scaffoldBackgroundColor),
                          image:
                              DecorationImage(image: NetworkImage(imageUrl!))),
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
