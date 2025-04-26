import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stocku_app/app/modules/user/signIn.dart';

import '../../controllers/authController.dart';
import '../../widgets/notifikasiWidget.dart' show NotifikasiWidget;

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String username = 'Memuat...';
  String email = 'Memuat...';
  final authController = AuthController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    await authController.ambilUserData();
    final penyimpanan = GetStorage();

    setState(() {
      username = penyimpanan.read('username') ?? 'Tidak ada nama';
      email = penyimpanan.read('email') ?? 'Tidak ada email';
    });
  }

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
                      Container(color: Colors.white, width: double.infinity, height: 90),
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
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Colors.black.withOpacity(0.1),
                            )
                          ],
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
                                  username,
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
                                      email,
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
                  onTap: () async {
                    await showDialog(
                    context: context,
                    builder: (context) {
                      return NotifikasiWidget(
                        onYes: () {
                          GetStorage().erase();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Signin()),
                          );
                        },
                        message: 'Apakah anda yakin keluar?',
                      );
                    });
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
