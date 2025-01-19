import 'package:cabzing_driver_app_hiba/CONSTANTS/Call_Functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/Image_paths.dart';
import '../CONSTANTS/Text_Style.dart';
import '../CONSTANTS/dimentions.dart';
import '../CONSTANTS/my_colors.dart';
import '../CONSTANTS/widgets.dart';
import '../PROVIDER/Login_Provider.dart';
import '../PROVIDER/dashboard_provider.dart';
import 'Bottam_Navigation_Screen.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.clBlack,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: Dimensions.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: Dimensions.spaceBetween,
                  children: [
                    const SizedBox(),
                    Padding(
                      padding: Dimensions.allpadding,
                      child: Row(
                        children: [
                          Image.asset(
                            languageSymbol,
                            scale: 5,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "English",
                            style: TextStyles.textStyle5,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height / 6,
                ),
                Column(
                  children: [
                    const Text(
                      "Login",
                      style: TextStyles.textStyle2,
                    ),
                    const Text(
                      "Login to your vikn account",
                      style: TextStyles.textStyle1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: Dimensions.buttonPadding,
                      width: width,
                      height: 125,
                      decoration: BoxDecoration(
                        color: AppColors.cll1A2D3B,
                        borderRadius: Dimensions.smallRadius,
                        border: Border.all(
                            color: AppColors.lightblueShade, width: 1),
                      ),
                      child: Consumer<LoginProvider>(
                          builder: (context, value, child) {
                        return Column(
                          children: [
                            UserNameTextField(value.usernameController),
                            const SizedBox(
                              height: 15,
                            ),
                            passwordTextField(
                                value.passwordController,
                                !value.isPasswordVisible,
                                value.toggleVisibility),
                          ],
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Forgotten Password?",
                      style: TextStyles.textStyle3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer2<LoginProvider, SalesProvider>(
                        builder: (context, value, dashbordProvider, child) {
                      return InkWell(
                        onTap: () {
                          final FormState? form = formKey.currentState;
                          if (form!.validate()) {
                            final username =
                                value.usernameController.text.trim();
                            final password =
                                value.passwordController.text.trim();
                            value.login(username, password).then((_) {
                              print("success fully loggined");
                              callNextReplacement(
                                  context,
                                  BottomNavigation_Screen(
                                    userId: '',
                                    Token: '',
                                  ));
                            });
                          }
                        },
                        child: value.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Container(
                                height: 48,
                                width: 125,
                                decoration: BoxDecoration(
                                  color: AppColors.btncolor,
                                  borderRadius: Dimensions.radius20,
                                ),
                                child: const Row(
                                  mainAxisAlignment: Dimensions.spacecenter,
                                  children: [
                                    Text(
                                      "Sign in",
                                      style: TextStyles.textStyle4,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.arrow_forward,
                                      color: AppColors.clWhite,
                                    )
                                  ],
                                ),
                              ),
                      );
                    })
                  ],
                ),
                SizedBox(
                  height: height / 5,
                ),
                const Column(
                  crossAxisAlignment: Dimensions.crossspacecenter,
                  children: [
                    Text(
                      "Don’t have an Account?",
                      style: TextStyles.textStyle6,
                    ),
                    Text(
                      "Sign up now!",
                      style: TextStyles.textStyle3,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
