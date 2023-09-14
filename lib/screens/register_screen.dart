import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/screens/forget_password_screen.dart';
import 'package:worker_tasks_app/screens/login_screen.dart';
import 'package:worker_tasks_app/widgets/custem_button.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';
import 'package:worker_tasks_app/widgets/custem_textformfield.dart';

import '../helper_methods/submit_method.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'loginScreen';

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
  FocusNode? emailNode = FocusNode();
  FocusNode? passNode = FocusNode();
  FocusNode? fullnameNode = FocusNode();
  FocusNode? posNode = FocusNode();

  final _registerKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _fullnameController.dispose();
    _posController.dispose();
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
                      aligment: Alignment.topLeft,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text_one: 'Already have an account ? ',
                      text_two: 'Log in'),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Form(
                    key: _registerKey,
                    child: Column(
                      children: [
                        CustemTextFormField(
                            onEditing: () {
                              FocusScope.of(context).requestFocus(emailNode);
                            },
                            txtInputAction: TextInputAction.next,
                            focusNodee: fullnameNode,
                            Controller: _fullnameController,
                            inputType: TextInputType.name,
                            hintString: 'Full Name'),
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
                            onEditing: () {
                              submitMethod(context, _registerKey);
                            },
                            txtInputAction: TextInputAction.next,
                            focusNodee: posNode,
                            Controller: _posController,
                            hintString: 'Position in the Company'),
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
