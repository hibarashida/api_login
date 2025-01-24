import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CONSTANTS/Alerts_Widgets.dart';
import '../CONSTANTS/Image_paths.dart';
import '../testScreen.dart';
import 'Dashboard_Screen.dart';
import 'Profile_Screen.dart';

class BottomNavigation_Screen extends StatelessWidget {
  String userId;
  String Token;
  BottomNavigation_Screen({
    required this.userId,
    required this.Token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MainProvider provider = Provider.of<MainProvider>(context, listen: true);
    final pages = [
       DashboardScreen(userId: userId, token: Token,),
      const Testscreen(),
      const Testscreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showExitPopup(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.clBlack,
        bottomNavigationBar: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    provider.onItemTapped(0);
                  },
                  icon: provider.selectedIndex == 0
                      ? const Column(
                          children: [
                            Icon(
                              Icons.home,
                              color: AppColors.clWhite,
                            ),
                            CircleAvatar(
                              radius: 2,
                              backgroundColor: AppColors.clWhite,
                            )
                          ],
                        )
                      : Image.asset(homeicone)),
              IconButton(
                onPressed: () {
                  provider.onItemTapped(1);
                },
                icon: provider.selectedIndex == 1
                    ? Column(
                        children: [
                          Image.asset(telegramIconwhite,height: 20,width: 20),
                          const CircleAvatar(
                            radius: 2,
                            backgroundColor: AppColors.clWhite,
                          )
                        ],
                      )
                    : Image.asset(telegramIcondark,),
              ),
              IconButton(
                  onPressed: () {
                    provider.onItemTapped(2);
                  },
                  icon: provider.selectedIndex == 2
                      ? const Column(
                          children: [
                            Icon(Icons.notifications_none_sharp,
                                color: AppColors.clWhite),
                            CircleAvatar(
                              radius: 2,
                              backgroundColor: AppColors.clWhite,
                            )
                          ],
                        )
                      : const Icon(
                          Icons.notifications_none_sharp,
                          color: AppColors.textFormFieldBorderColor,
                        )),
              IconButton(
                  onPressed: () async {
      
                    provider.onItemTapped(3);
                    provider.fetchUserDetails(userId);
                  },
                  icon: provider.selectedIndex == 3
                      ? const Column(
                          children: [
                            Icon(
                              Icons.perm_identity_rounded,
                              color: AppColors.clWhite,
                            ),
                            CircleAvatar(
                              radius: 2,
                              backgroundColor: AppColors.clWhite,
                            )
                          ],
                        )
                      : const Icon(
                          Icons.perm_identity_rounded,
                          color: AppColors.textFormFieldBorderColor,
                        ))
            ],
          ),
        ),
        body: pages[provider.selectedIndex],
      ),
    );
  }
}
