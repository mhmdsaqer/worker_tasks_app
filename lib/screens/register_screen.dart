import 'dart:io';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/helper_methods/selet_catagory.dart';
import 'package:worker_tasks_app/helper_methods/show_picture_dialog.dart';
import 'package:worker_tasks_app/helper_methods/show_select_job.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/widgets/custem_button.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';
import 'package:worker_tasks_app/widgets/custem_textformfield.dart';

import '../helper_methods/show_picture_dialog.dart';
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
  File? imageFile;
  FocusNode? emailNode = FocusNode();
  FocusNode? passNode = FocusNode();
  FocusNode? fullnameNode = FocusNode();
  FocusNode? posNode = FocusNode();
  FocusNode? phoneNode = FocusNode();
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
          //for the image in the background
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
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  showPicDialog(context, imageFile);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 5, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: ClipRect(
                                        child: imageFile == null
                                            ? Image(
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    'https://static.vecteezy.com/system/resources/previews/005/544/718/non_2x/profile-icon-design-free-vector.jpg'))
                                            : Image(
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.fill,
                                                image: FileImage(imageFile!),
                                              ),
                                      ),
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
                            txtInputAction: TextInputAction.done,
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  CustemButton(
                      text: "Register",
                      onPressed: () {
                        submitMethod(context, _registerKey);
                      },
                      icon: Icon(
                        Icons.new_label,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
