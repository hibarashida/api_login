import 'dart:io';

import 'package:cabzing_driver_app_hiba/CONSTANTS/Call_Functions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Text_Style.dart';

logOutAlert({required Function() onTap, required BuildContext context}) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: Dimensions.smallRadius10),
    backgroundColor: AppColors.clWhite,
    scrollable: true,
    title: const Column(
      crossAxisAlignment: Dimensions.crossspacestart,
      children: [
        Text(
          "Confirm Logout",
          style: TextStyles.textStyleblack15,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Are you sure want to logout? ",
          style: TextStyles.textStyleblack12,
        ),
      ],
    ),
    content: Row(
      mainAxisAlignment: Dimensions.spaceend,
      children: [
        Container(
          height: 35,
          width: 80,
          decoration: BoxDecoration(
              color: AppColors.clWhite,
              borderRadius: Dimensions.smallRadius111,
              boxShadow: const [
                BoxShadow(
                    offset: Offset(3, 4),
                    blurRadius: 8,
                    spreadRadius: -1,
                    color: AppColors.black12),
              ]),
          child: TextButton(
              child: const Text(
                'Cancel',
                style: TextStyles.textStyleblack800,
              ),
              onPressed: () {
                back(context);
              }),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
            height: 35,
            width: 80,
            decoration: BoxDecoration(
                color: AppColors.redcolor,
                borderRadius: Dimensions.smallRadius111),
            child: TextButton(
                child: const Text(
                  'Logout',
                  style: TextStyles.textStyle5,
                ),
                onPressed: () async {
                  onTap();
                })),
      ],
    ),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: Dimensions.smallRadius10),
            backgroundColor: AppColors.clWhite,
            scrollable: true,
            title: const Column(
              crossAxisAlignment: Dimensions.crossspacestart,
              children: [
                Text(
                  "Confirm Exit",
                  style: TextStyles.textStyleblack15,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Are you sure want to Exit? ",
                  style: TextStyles.textStyleblack12,
                ),
              ],
            ),
            content: Row(
              mainAxisAlignment: Dimensions.spaceend,
              children: [
                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppColors.clWhite,
                      borderRadius: Dimensions.smallRadius111,
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(3, 4),
                            blurRadius: 8,
                            spreadRadius: -1,
                            color: AppColors.black12),
                      ]),
                  child: TextButton(
                      child: const Text(
                        'No',
                        style: TextStyles.textStyleblack800,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    height: 35,
                    width: 80,
                    decoration: BoxDecoration(
                        color: AppColors.clBlack,
                        borderRadius: Dimensions.smallRadius111),
                    child: TextButton(
                        child: const Text(
                          'Yes',
                          style: TextStyles.textStyle5,
                        ),
                        onPressed: () async {
                          exit(0);
                        })),
              ],
            ),
          );
        },
      ) ??
      false; // In case the dialog is dismissed in another way
}
