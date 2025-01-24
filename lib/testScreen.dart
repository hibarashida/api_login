import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CONSTANTS/Image_paths.dart';
import 'CONSTANTS/Text_Style.dart';
import 'CONSTANTS/dimentions.dart';
import 'CONSTANTS/widgets.dart';

class Testscreen extends StatelessWidget {
  const Testscreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.clBlack,
      ),
    );
  }
}
