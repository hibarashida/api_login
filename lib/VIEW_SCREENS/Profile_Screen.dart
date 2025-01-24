import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Login_Provider.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/Alerts_Widgets.dart';
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
                margin: Dimensions.buttonspacePadding,
                height: height/1.99,
                width: width,
                decoration: BoxDecoration(
                    color: AppColors.blackishcolor,
                    borderRadius: Dimensions.smallRadius44),
                child: Padding(
                  padding: Dimensions.allpaddings,
                  child: Column(
                    crossAxisAlignment: Dimensions.crossspacestart,
                    mainAxisAlignment: Dimensions.spaceBetwwen,
                    children: [
                      Padding(
                        padding: Dimensions.commonpadding8,
                        child: Row(
                          mainAxisAlignment: Dimensions.spaceBetween,
                          children: [
                            Consumer<MainProvider>(
                                builder: (context,value,child) {
                                return Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: AppColors.clBlack,
                                      borderRadius: Dimensions.smallRadius33,
                                  image: DecorationImage(image: value.userPhoto.isNotEmpty?
                                  NetworkImage(value.userPhoto):AssetImage(profileImage),fit: BoxFit.cover)),

                                );
                              }
                            ),
                            SizedBox(width: 5,),
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
                            SizedBox(width: 5,),
                            const Icon(
                              Icons.edit,
                              color: AppColors.clWhite,
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: Dimensions.spacespaceEvenly,
                        children: [
                          profileConatiners(width / 2.6),
                          profileVerifiedContainers(width / 2.4)
                        ],
                      ),
                      SizedBox(height: 5,),
                      Consumer<LoginProvider>(
                        builder: (context,value,child) {
                          return logoutBtn(onTap: () {
                            logOutAlert(onTap: () {  value.logout(context); }, context: context);
                            }, width: width);
                        }
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:Dimensions.buttonspaceprofileSidePadding,
                child: Column(
                crossAxisAlignment: Dimensions.crossspacestart,
                  children: [
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

               ],
          ),
        ),
      ),
    );
  }
}
