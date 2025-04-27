import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stocku_app/app/modules/user/home.dart';
import 'package:stocku_app/app/modules/user/signIn.dart';
import 'package:get/get.dart';

import 'app/controllers/laporanController.dart';
import 'app/modules/user/signUp.dart';
import 'app/widgets/splashScreen.dart';

Future<void> cekDanKirimStokKeOldData() async {
  final now = DateTime.now();

  if (now.day == 1) {
    final laporanController = Get.put(LaporanController());
    laporanController.kirimStokKeOldProd();
  }
}


Future<void> main() async {
  await GetStorage.init();
  await GetStorage.init('stokBulanIni');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'StockU',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreenPage()),
        GetPage(name: '/signUp', page: () => Signup()),
        GetPage(name: '/signIn', page: () => Signin()),
        GetPage(name: '/home', page: () => Home())
      ],
    );
  }
}