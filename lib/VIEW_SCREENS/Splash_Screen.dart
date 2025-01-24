import 'dart:async';

import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CONSTANTS/Call_Functions.dart';
import '../CONSTANTS/Image_paths.dart';
import 'Bottam_Navigation_Screen.dart';
import 'Login_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  @override

  void initState()  {
      localDB().then((_) {


        Timer(const Duration(seconds: 1), () async {
          localDB();
          String? userId = prefs.getString("userID");
          String? token = prefs.getString("token");
    if (userId == null) {
            callNextReplacement(  context,LoginScreen());
          }
          else {
            callNextReplacement(  context,BottomNavigation_Screen(userId: userId, Token: token!,));

          }

        });});



      super.initState();





  }
  Future<void> localDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.clBlack,
      body: Column(
        mainAxisAlignment: Dimensions.spaceBetween,

        children: [
          SizedBox(),
          Image.asset(logoImage),
          SizedBox(),
        ],

      ),

    );
  }
}
