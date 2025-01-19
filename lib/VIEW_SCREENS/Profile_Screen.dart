import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Login_Provider.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/Image_paths.dart';
import '../CONSTANTS/Text_Style.dart';
import '../CONSTANTS/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.clBlack,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: Dimensions.padding,
                height: 335,
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.blackishcolor,
                    borderRadius: Dimensions.smallRadius44),
                child: Column(
                  crossAxisAlignment: Dimensions.crossspacestart,
                  mainAxisAlignment: Dimensions.spaceBetwwen,
                  children: [
                    Padding(
                      padding: Dimensions.allpaddings,
                      child: Row(
                        mainAxisAlignment: Dimensions.spaceBetween,
                        children: [
                          Consumer<MainProvider>(
                              builder: (context,value,child) {
                              return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: AppColors.clBlack,
                                    borderRadius: Dimensions.smallRadius44),
                                child: Center(child: value.userPhoto.isNotEmpty?Image.network(value.userPhoto):Image.asset(profileImage)),
                              );
                            }
                          ),
                          Consumer<MainProvider>(
                              builder: (context,value,child) {
                              return  Column(
                                crossAxisAlignment: Dimensions.crossspacestart,
                                children: [
                                  Text(value.userName,style: TextStyles.textStyle20,),
                                  Text(value.userEmail,style: TextStyles.textStyle14),
                                ],
                              );
                            }
                          ),
                          const Icon(
                            Icons.edit,
                            color: AppColors.clWhite,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: Dimensions.spacespaceEvenly,
                      children: [
                        profileConatiners(width / 2.4),
                        profileVerifiedContainers(width / 2.4)
                      ],
                    ),
                    Consumer<LoginProvider>(
                      builder: (context,value,child) {
                        return logoutBtn(onTap: () {value.logout(context);}, width: width);
                      }
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              profileListTile(icon: Icons.help_outline, title: 'Help'),
              const SizedBox(
                height: 15,
              ),
              profileListTile(icon: Icons.search_off, title: 'FAQ'),
              const SizedBox(
                height: 15,
              ),
              profileListTile(
                  icon: Icons.person_add_alt, title: 'Invite Friends'),
              const SizedBox(
                height: 15,
              ),
              profileListTile(
                  icon: Icons.verified_user, title: 'Terms of service'),
              const SizedBox(
                height: 15,
              ),
              profileListTile(
                  icon: Icons.privacy_tip_outlined, title: 'Privacy Policy'),
            ],
          ),
        ),
      ),
    );
  }
}
