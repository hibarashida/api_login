import 'package:cabzing_driver_app_hiba/CONSTANTS/Call_Functions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Main_Provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CONSTANTS/Image_paths.dart';
import '../CONSTANTS/widgets.dart';
import '../PROVIDER/dashboard_provider.dart';
import 'Sale_List_Screen.dart';

class DashboardScreen extends StatelessWidget {
  String userId;
  String token;
   DashboardScreen({super.key,required this.userId,required this.token});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.clBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.clBlack,
          title: SizedBox(
            height: 39,
            width: 138,
            child: Image.asset(
              logoImage,
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            Consumer<MainProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: Dimensions.allpaddings,
                  child: GestureDetector(
                    onTap: () {
                      value.toggleImage();
                    },
                    child: value.isFirstImage
                        ? Image.asset(
                            profileImageRed,
                            key: ValueKey('first_image'),
                            width: 34,
                            height: 34,
                          )
                        : Image.asset(
                            profileImageGreen,
                            key: ValueKey('second_image'),
                            width: 34,
                            height: 34,
                          ),
                  ),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: Dimensions.buttonsPadding,
                width: width,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: Dimensions.smallRadius24,
                    image: DecorationImage(image: AssetImage(homescreenImage),fit: BoxFit.cover)),
              ),
          Consumer2<MainProvider,SalesProvider>(
            builder: (context,value,dashbordProvider,child) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                itemCount: value.dashboardData.length,
                itemBuilder: (context, index) {
                  final data = value.dashboardData[index];
                  return DashboardCard(
                    icon: data['icon'],
                    title: data['title'],
                    value: data['value'],
                    subtitle: data['subtitle'],
                    onTap: () async {
                      if(index==1){
                        dashbordProvider.fetchSales(1,userId,token);
                        callNext(context, SaleListScreen());
                      }
                      print('${data['title']} clicked');
                    },
                  );
                },
              );
            }
          )
            ],
          ),
        ),
      ),
    );
  }
}
