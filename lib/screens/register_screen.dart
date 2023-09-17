import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/helper_methods/selet_catagory.dart';
import 'package:worker_tasks_app/helper_methods/show_pic_options.dart';
import 'package:worker_tasks_app/helper_methods/show_select_job.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/screens/user_state.dart';
import 'package:worker_tasks_app/widgets/custem_button.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';
import 'package:worker_tasks_app/widgets/custem_textformfield.dart';
import '../helper_methods/submit_method.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _posController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  FocusNode? emailNode = FocusNode();
  FocusNode? passNode = FocusNode();
  FocusNode? fullnameNode = FocusNode();
  FocusNode? posNode = FocusNode();
  FocusNode? phoneNode = FocusNode();
  bool isLoding = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? url;
  final _registerKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _fullnameController.dispose();
    _posController.dispose();
    _imageController.dispose();
    _phoneController.dispose();
    emailNode!.dispose();
    passNode!.dispose();
    fullnameNode!.dispose();
    posNode!.dispose();

    super.dispose();
  }

  void updateImage(File newImage) {
    setState(() {
      imageFile = newImage;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.ease)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://images.unsplash.com/photo-1541746972996-4e0b0f43e02a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  const Text('Register', style: mainTextStyle),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustemRichText(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, LoginScreen.id);
                      },
                      text_one: 'Already have an account ?',
                      text_two: 'Log in',
                      aligment: Alignment.topLeft),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Form(
                    key: _registerKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: CustemTextFormField(
                                  onEditing: () {
                                    FocusScope.of(context)
                                        .requestFocus(emailNode);
                                  },
                                  txtInputAction: TextInputAction.next,
                                  focusNodee: fullnameNode,
                                  Controller: _fullnameController,
                                  inputType: TextInputType.name,
                                  hintString: 'Full Name'),
                            ),
                            Flexible(
                              child: InkWell(
                                onTap: () {
                                  showPicOptions(
                                      context, imageFile, updateImage);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: imageFile == null
                                              ? Image.network(
                                                  'https://1fid.com/wp-content/uploads/2022/06/no-profile-picture-2-1024x1024.jpg')
                                              : Image.file(
                                                  File(imageFile!.path))),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.pink.shade800,
                                          radius: 15,
                                          child: Icon(
                                            Icons.linked_camera,
                                            color: Colors.white,
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustemTextFormField(
                            onEditing: () {
                              FocusScope.of(context).requestFocus(passNode);
                            },
                            txtInputAction: TextInputAction.next,
                            focusNodee: emailNode,
                            Controller: _emailController,
                            inputType: TextInputType.emailAddress,
                            hintString: 'Email'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustemTextFormField(
                            onEditing: () {
                              FocusScope.of(context).requestFocus(posNode);
                            },
                            txtInputAction: TextInputAction.next,
                            focusNodee: passNode,
                            Controller: _passController,
                            inputType: TextInputType.visiblePassword,
                            hintString: 'Password'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustemTextFormField(
                            inputType: TextInputType.phone,
                            onEditing: () {
                              FocusScope.of(context).requestFocus(posNode);
                            },
                            txtInputAction: TextInputAction.next,
                            focusNodee: phoneNode,
                            Controller: _phoneController,
                            hintString: 'Phone Number'),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            selectJob(context, _posController);
                          },
                          child: CustemTextFormField(
                              onEditing: () {
                                submitMethod(context, _registerKey);
                              },
                              enabeld: true,
                              txtInputAction: TextInputAction.next,
                              focusNodee: posNode,
                              Controller: _posController,
                              hintString: 'Position in the Company'),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                        CustemButton(
                          isLoding: isLoding,
                          text: "Register",
                          onPressed: () async {
                            bool isValid = submitMethod(context, _registerKey);
                            if (isValid) {
                              if (imageFile == null) {
                                var snakBar = SnackBar(
                                  content: Text(
                                    'Please choose a Profile Photo',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakBar);
                                return;
                              }
                              setState(() {
                                isLoding = true;
                              });
                              try {
                                await _auth.createUserWithEmailAndPassword(
                                    email: _emailController.text
                                        .toLowerCase()
                                        .trim(),
                                    password: _passController.text.trim());
                                final User? user = _auth.currentUser;
                                final uid = user!.uid;
                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child('usersImages')
                                    .child(uid + 'jpg');
                                await ref.putFile(imageFile!);
                                url = await ref.getDownloadURL();
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc('Id')
                                    .set({
                                  'id': uid,
                                  'userImageUrl': url,
                                  'name': _fullnameController.text,
                                  'email': _emailController.text,
                                  'pass': _passController.text,
                                  'phoneNum': _phoneController.text,
                                  'pos': _posController.text,
                                  'ceratedAt': Timestamp.now(),
                                });

                                Navigator.canPop(context)
                                    ? Navigator.pop(context)
                                    : Navigator.pushReplacementNamed(
                                        context, UserStateScreen.id);
                                var snakBar = SnackBar(
                                  content: Text(
                                    'Succssesfully , Please Log in ',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakBar);
                              } catch (ex) {
                                var snakBar = SnackBar(
                                  content: Text('$ex'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakBar);
                              }
                            }
                            setState(() {
                              isLoding = false;
                            });
                          },
                          icon: Icon(
                            Icons.new_label,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
