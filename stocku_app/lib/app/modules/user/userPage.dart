import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stocku_app/app/modules/user/signIn.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      Container(color: Color(0xFFEA8D45), width: double.infinity, height: 172),
                      Container(color: Colors.white, width: double.infinity, height: 172),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 90,
                        margin: EdgeInsets.only(top: 127, left: 25, right: 25),
                        padding: EdgeInsets.only(left: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0,2),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.1)
                              )
                            ]
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'lib/assets/icon/userfilled_icon.svg',
                              width: 52,
                              height: 52,
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Acepi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'lib/assets/icon/email_icon.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'acfyyr@gmail.com',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                        color: Color(0xFF717171),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 33),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Tentang Stocku',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(height: 21),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Berkaitan Stocku',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 5),
              Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.only(left: 26, right: 26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Signin()),
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/icon/signout_icon.svg',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 11),
                        Text(
                          'Keluar',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFA44930),
                          ),
                        ),
                      ],
                    ),
                  )
              )
            ],
          ),
          )
      )
    );
  }
}
