import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stocku_app/app/modules/user/home.dart';
import 'package:stocku_app/app/modules/user/signIn.dart';
import 'package:get/get.dart';

import 'app/modules/user/signUp.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'StockU',
      initialRoute: '/signIn',
      getPages: [
        GetPage(name: '/signUp', page: () => Signup()),
        GetPage(name: '/signIn', page: () => Signin()),
        GetPage(name: '/home', page: () => Home())
      ],
    );
  }
}