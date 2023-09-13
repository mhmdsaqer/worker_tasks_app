import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:worker_tasks_app/constants.dart';
import 'package:worker_tasks_app/widgets/custem_textformfield.dart';

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
  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passController.dispose();
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
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Don\'t have an account ? ',
                          style: TextStyle(color: Colors.white)),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print(''),
                        text: 'Register',
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CustemTextFormField(
                    Controller: _emailController,
                    inputType: TextInputType.emailAddress,
                    hintString: 'Email'),
                CustemTextFormField(
                    passSecurity: true,
                    Controller: _passController,
                    inputType: TextInputType.visiblePassword,
                    hintString: 'Password'),
                passTextField()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget passTextField() {
    return Row(
      children: [
        TextFormField(
          style: TextStyle(color: Colors.white),
          controller: _passController,
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            hintText: 'hintString',
            hintStyle: TextStyle(color: Colors.white),
            border: const UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow)),
            errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.remove_red_eye_outlined))
      ],
    );
  }
}
