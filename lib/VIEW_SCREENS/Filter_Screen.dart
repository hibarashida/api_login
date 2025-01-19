import 'package:cabzing_driver_app_hiba/CONSTANTS/Call_Functions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/Main_Provider.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/dashboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/Text_Style.dart';
import '../CONSTANTS/widgets.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.clBlack,

      appBar:  AppBar(
        backgroundColor:AppColors.clBlack,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: AppColors.clWhite,),
          onPressed: () {
            back(context);
          },
        ),
        title:  Text("Filter",style: TextStyles.textStyle7),
        centerTitle: false,
        actions:  const [   Padding(
          padding: Dimensions.allpaddings,
          child: Row(
            children: [
              Icon(Icons.visibility_outlined,color: AppColors.locationColor,),
              SizedBox(width: 2,),
              Text("Filter",style: TextStyles.textStyle3)
            ],
          ),
        ),],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: 1,
              color: AppColors.lightblueShade,
            ),

            SizedBox(height: 15,),
            monthConatiner(),
            SizedBox(height: 20,),
            Consumer<SalesProvider>(
              builder: (context,value,child) {
                return Row(
                  mainAxisAlignment: Dimensions.spacespaceEvenly,
                  children: [
                    calenderConatiner( onTap: () {  value.selectDate(context);}, ct: value.startdateController,),
                    calenderConatiner( onTap: () {  value.endSelectDate(context);}, ct: value.enddateController,),
                  ],
                );
              }
            ),
            SizedBox(height: 25,),
            Container(
              width: width,
              height: 1,
              color: AppColors.lightblueShade,
            ),
            Consumer<MainProvider>(
                builder: (context,value,child) {
                return SizedBox(
                  height: 55,
                  width: width,
                  child: ListView.builder(
                    itemCount: value.filters.length,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.horizontal,

                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return
                      filterContainer(  onTap: () {

                        value. updateSelectedIndex(index); // Update selected index
                      },
                        text: value.filters[index],
                        isSelected:  value. selectedFilterIndex == index,);

                    },),
                );
              }
            ),



            container(width,(),"Customer"),




          ],
        ),
      ),
    );
  }
}
