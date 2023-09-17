import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/helper_methods/submit_method.dart';
import 'package:worker_tasks_app/screens/home_screen.dart';

import 'package:worker_tasks_app/screens/register_screen.dart';
import 'package:worker_tasks_app/widgets/custem_button.dart';
import 'package:worker_tasks_app/widgets/custem_rich_text.dart';
import 'package:worker_tasks_app/widgets/custem_textformfield.dart';

import '../helper_methods/show_forgetpass.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _forgetPassController = TextEditingController();
  FocusNode submitNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FocusNode emailNode = FocusNode();
  FocusNode passNode = FocusNode();
  bool isLoding = false;
  final _loginKey = GlobalKey<FormState>();
  final _forgetpassKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _forgetPassController.dispose();
    emailNode.dispose();
    passNode.dispose();
    submitNode.dispose();

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
                  const Text('Login', style: mainTextStyle),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustemRichText(
                      aligment: Alignment.topLeft,
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RegisterScreen.id);
                      },
                      text_one: 'Don\'t have an account ? ',
                      text_two: 'Register'),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Form(
                    key: _loginKey,
                    child: Column(
                      children: [
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
                            txtInputAction: TextInputAction.done,
                            onEditing: () {
                              submitMethod(context, _loginKey);
                            },
                            focusNodee: passNode,
                            Controller: _passController,
                            inputType: TextInputType.visiblePassword,
                            hintString: 'Password'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  CustemRichText(
                      aligment: Alignment.bottomRight,
                      onTap: () {
                        showPassWidget(
                            context, _forgetPassController, _forgetpassKey);
                      },
                      text_one: 'Forget your password ? ',
                      text_two: 'Click Here'),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustemButton(
                      isLoding: isLoding,
                      text: "Login",
                      onPressed: () async {
                        bool isValid = submitMethod(context, _loginKey);
                        if (isValid) {
                          setState(() {
                            isLoding = true;
                          });
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email:
                                    _emailController.text.toLowerCase().trim(),
                                password: _passController.text.trim());

                            Navigator.canPop(context)
                                ? Navigator.pop(context)
                                : Navigator.pushReplacementNamed(
                                    context, HomeScreen.id);
                          } catch (ex) {
                            var snakBar = SnackBar(
                              content: Text('$ex'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakBar);
                          }
                        }
                        setState(() {
                          isLoding = false;
                        });
                      },
                      icon: Icon(
                        Icons.login,
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
