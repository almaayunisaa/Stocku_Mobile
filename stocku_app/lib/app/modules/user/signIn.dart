import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/modules/user/home.dart';
import 'package:stocku_app/app/modules/user/signUp.dart';
import 'package:stocku_app/app/widgets/textField.dart';
import 'package:get/get.dart';

import '../../controllers/authController.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Color(0xFFEA8D45),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 41),
                Padding(
                  padding: EdgeInsets.only(top: 36, left: 36, right: 36),
                  child: Row(
                    children: [
                      Text(
                        'MASUK',
                        style: TextStyle(
                            fontSize: 32,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                      ),
                      SvgPicture.asset(
                        'lib/assets/img/orangHome.svg',
                        width: 100,
                        height: 100,
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(28), topLeft: Radius.circular(28)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(34),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selamat Datang!',
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 18),
                        Text(
                          'Silahkan masukkan Username dan Kata Sandi Anda.',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Color(0xFFAEA5A5)
                          ),
                        ),
                        SizedBox(height: 22),
                        CustomTextField(hintText: 'Username', iconPath: 'lib/assets/icon/user_icon.svg', controller: authController.usernameController),
                        SizedBox(height: 15),
                        CustomTextField(hintText: 'Kata Sandi', iconPath: 'lib/assets/icon/user_icon.svg', controller: authController.passwordController, isPassword: true),
                        SizedBox(height: 23),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                authController.signIn(authController.usernameController.text, authController.passwordController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFEA8D45),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                'Masuk',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              )
                          ),
                        ),
                        Spacer(),
                        Center(
                            child: RichText(
                                text: TextSpan(
                                    text: 'Belum punya akun? ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Buat',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: Color(0xFFE33629),
                                          decoration: TextDecoration.underline,
                                          decorationColor: Color(0xFFE33629),
                                          decorationThickness: 1,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed('/signUp');
                                          },
                                      )
                                    ]
                                )
                            )
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          )
    );
  }
}
