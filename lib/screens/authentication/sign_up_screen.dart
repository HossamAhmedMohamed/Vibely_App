// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/controllers/auth_controller.dart';
import 'package:social_media_app/providers/sign_up_provider.dart';
import 'package:social_media_app/utils/app_images.dart';
import 'package:social_media_app/utils/app_styles.dart';
import 'package:social_media_app/utils/pages_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return Scaffold(
      body: signUpProvider.isLoading
          ? fluent_ui.Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                      width: 250, height: 250, Assets.imagesMerhabaLogoLight),
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
                    label: 'Enter your full name:',
                    child: fluent_ui.TextBox(
                      placeholder: 'Full name',
                      expands: false,
                      controller: fullNameController,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  fluent_ui.InfoLabel(
                    label: 'Enter your phone:',
                    child: fluent_ui.TextBox(
                      placeholder: 'Phone',
                      expands: false,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
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
                    height: 20,
                  ),
                  fluent_ui.InfoLabel(
                    label: 'Confirm your password:',
                    child: fluent_ui.TextBox(
                      placeholder: 'confirm your password',
                      expands: false,
                      controller: confirmPasswordController,
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
                        'Sign up',
                        style: AppStyle.styleBold17(context)
                            .copyWith(color: Colors.white),
                      ),
                      onPressed: () async{
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

                        if (fullNameController.text == '') {
                          Fluttertoast.showToast(
                              msg: 'Please enter your full name');
                          return;
                        }

                        if (phoneController.text == '') {
                          Fluttertoast.showToast(
                              msg: 'Please enter your phone');
                          return;
                        }

                        if (confirmPasswordController.text == '') {
                          Fluttertoast.showToast(
                              msg: 'Please enter your confirm password');
                          return;
                        }

                        if (confirmPasswordController.text != passwordController.text) {
                          Fluttertoast.showToast(
                              msg: 'Password and confirm password must be equal');
                          return;
                        }

                        signUpProvider.toggleLoading();

                        try {
                          var res = await AuthController.createAccount(
                               {
                                'email': emailController.text.toLowerCase().trim(),
                                'password': passwordController.text,
                                'fullName': fullNameController.text,
                                'phone': phoneController.text,

                               });

                          if (res["result"] == true) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, loginScreen, (routes) => false);
                          } else {
                            signUpProvider.toggleLoading();
                            Fluttertoast.showToast(
                              msg: res["message"].toString(),
                            );
                          }
                        } catch (e) {
                          signUpProvider.toggleLoading();
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Already have account?",
                          style: AppStyle.styleRegular17(context).copyWith(
                              fontWeight: FontWeight.w600, color: Colors.white),
                          children: <TextSpan>[
                        TextSpan(
                          text: ' ',
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, loginScreen);
                              },
                            text:
                                //  'you@example.com',
                                'Login',
                            style: AppStyle.styleRegular17(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue)),
                      ])),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}
