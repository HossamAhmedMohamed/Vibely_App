// ignore_for_file: use_build_context_synchronously

import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/auth_controller.dart';
import 'package:social_media_app/providers/login_provider.dart';
import 'package:social_media_app/utils/app_images.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:social_media_app/utils/pages_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: loadingProvider.isLoading
          ? fluent_ui.Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(Assets.imagesMerhabaLogoLight),
                  fluent_ui.InfoLabel(
                    label: 'Enter your email:',
                    child: fluent_ui.TextBox(
                      placeholder: 'E-mail',
                      expands: false,
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  fluent_ui.InfoLabel(
                    label: 'Enter your Password:',
                    child: fluent_ui.TextBox(
                      placeholder: 'Password',
                      expands: false,
                      controller: passwordController,
                      obscureText: isVisible,
                      suffix: InkWell(
                          onTap: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          child: isVisible
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FilledButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                      child: Text(
                        'Login',
                        style: AppStyle.styleBold17(context)
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (emailController.text == '') {
                          Fluttertoast.showToast(
                              msg: 'Please enter your email');
                          return;
                        }

                        if (passwordController.text == '') {
                          Fluttertoast.showToast(
                              msg: 'Please enter your password');
                          return;
                        }

                        loadingProvider.toggleLoading();

                        try {
                          var res = await AuthController.login(
                              emailController.text, passwordController.text);

                          if (res["result"] == true) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, homeScreen, (routes) => false);
                          } else {
                            loadingProvider.toggleLoading();
                            Fluttertoast.showToast(
                              msg: res["message"].toString(),
                            );
                          }
                        } catch (e) {
                          loadingProvider.toggleLoading();
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Don't have account?",
                          style: AppStyle.styleRegular17(context).copyWith(
                              fontWeight: FontWeight.w600, color: Colors.white),
                          children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, signUpScreen);
                              },
                            text:
                                //  'you@example.com',
                                'Sign Up',
                            style: AppStyle.styleRegular17(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue)),
                      ])),
                ],
              ),
            ),
    );
  }
}
