import 'package:IoT_App/pages/ch_page.dart';
import 'package:IoT_App/pages/ch_support.dart';
import 'package:IoT_App/pages/select_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/home.dart';
import 'pages/intro.dart';
import 'pages/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp());
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  Widget goto(){
    if(box.hasData('intro')) {
      if(box.hasData('login')){
        return HomePage();
      }
      else{
        return LoginPage();
      }
    }
    else{
      return Intro();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Josefin",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      // ChPage(),
      SelectUser(),
      defaultTransition: Transition.rightToLeftWithFade,
    );
  }
}
