import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MODELS/Sales_Model_Class.dart';
import 'Image_paths.dart';
import 'Text_Style.dart';

Widget UserNameTextField(TextEditingController ct) {
  return TextFormField(
    controller: ct,
    style: TextStyles.textStyle5,
    keyboardType: TextInputType.name,
    decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        labelText: "Username",
        labelStyle: TextStyles.textStyle1,
        contentPadding: Dimensions.padding,
        prefixIcon: Icon(
          Icons.perm_identity_rounded,
          color: AppColors.locationColor,
        )),
    validator: (value) {
      if (value!.isEmpty) {
        return 'Please Enter username ';
      } else {
        return null;
      }
    },
  );
}

Widget passwordTextField(
    TextEditingController ct, bool passwordVisible, Function onTap) {
  return TextFormField(
    controller: ct,
    style: TextStyles.textStyle5,
    keyboardType: TextInputType.name,
    obscureText: passwordVisible,
    decoration: InputDecoration(
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      labelText: "Password",
      labelStyle: TextStyles.textStyle1,
      contentPadding: Dimensions.padding,
      prefixIcon: const Icon(Icons.key, color: AppColors.locationColor),
      suffixIcon: IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility_off : Icons.visibility,
          color: AppColors.locationColor,
        ),
        onPressed: () {
          onTap(); // Ensure the function is called here
        },
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty || value.length < 6) {
        return 'Please Enter Password of min length 6';
      }
      return null;
    },
  );
}

/// filterpage month container
Widget monthConatiner({
  required Function(String) onMonthChanged,
  required String selectedMonth,
  required List<String> months,
}) {
  return Container(
    height: 35,
    width: 132,
    decoration: BoxDecoration(
      color: AppColors.blueShade,
      borderRadius: Dimensions.radius20,
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedMonth == "This Month" ? null : selectedMonth,
        hint: Padding(
          padding: Dimensions.allpaddings,
          child: Row(
            mainAxisAlignment: Dimensions.spacecenter,
            children: [
              Text(
                selectedMonth,
                style: TextStyles.textStyle5,
              ),
            ],
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.clWhite,
        ),
        dropdownColor: AppColors.clBlack,
        items: months.map((month) {
          return DropdownMenuItem<String>(
            value: month,
            child: Padding(
              padding: Dimensions.allpaddingleft,
              child: Text(
                month,
                style: TextStyles.textStyle5,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onMonthChanged(value);
          }
        },
      ),
    ),
  );
}

/// filterpage calender containers

Widget calenderConatiner({
  required Function() onTap,
  required TextEditingController ct,
}) {
  return Container(
    margin: Dimensions.buttonspacesPadding,
    height: 38,
    width: 139,
    decoration: BoxDecoration(
      borderRadius: Dimensions.smallRadius24,
      color: AppColors.lightblue,
    ),
    child: InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: Dimensions.spacecenter,
        children: [
          const Icon(
            Icons.calendar_month,
            color: AppColors.btncolor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            ct.text.isNotEmpty ? ct.text : "select date",
            style: TextStyles.textStyle5,
          )
        ],
      ),
    ),
  );
}

/// filterpage filter conatiners

Widget filterContainer({
  required Function() onTap,
  required String text,
  required bool isSelected,
}) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: Dimensions.padding,
          height: 43,
          width: 95,
          decoration: BoxDecoration(
            borderRadius: Dimensions.smallRadius27,
            color: isSelected ? AppColors.blueshadE100 : AppColors.lightblue,
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyles.textStyle6,
          ))));
}

Widget container({
  required double width,
  required String text,
  required Function(SalesData) customers,
  required SalesData? selectedItem,
  required List<SalesData> names,
}) {
  return Column(
    children: [
      Container(
        margin: Dimensions.buttonsPadding,
        height: 50,
        width: width,
        decoration: BoxDecoration(
          borderRadius: Dimensions.smallRadius,
          color: AppColors.blueShade,
          border: Border.all(color: AppColors.lightblueShade, width: 1),
        ),
        child: Padding(
          padding: Dimensions.allpaddings,
          child: DropdownButton<SalesData>(
            isExpanded: true,
            value: selectedItem,
            hint: const Text(
              'Customer ',
              style: TextStyles.textStyle1,
            ),
            dropdownColor: AppColors.clBlack,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.clWhite,
              size: 20,
            ),
            items: names.map((SalesData item) {
              return DropdownMenuItem<SalesData>(
                value: item,

                child: Text(item.customerName), // Display the item's name
              );
            }).toList(),
            onChanged: (SalesData? newValue) {
              if (newValue != null) {
                customers(newValue); // Notify parent of the change
              }
            },
            underline: SizedBox.shrink(),
          ),
        ),
      ),
      const SizedBox(height: 10),
      Container(
        width: 65,
        height: 1,
        color: AppColors.lightblueShade,
      ),
    ],
  );
}

/// sales Screen search filed

Widget searchFiled({
  required Function(String) onChanged,
  required double width,
}) {
  return Container(
    height: 50,
    width: width,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: AppColors.lightblueShade,
      ),
      color: AppColors.lightblue,
      borderRadius: Dimensions.smallRadius8,
    ),
    child: TextFormField(
      onChanged: (value) {
        onChanged(value);
      },
      style: TextStyles.textStyle6,
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.clGrey,
        ),
        hintText: "Search",
        hintStyle:
            TextStyles.textStyle77, // Corrected from helperStyle to hintStyle
      ),
    ),
  );
}

/// sales Screen filter container
Widget filtersBtn({
  required Function() onTap,
  required double width,
}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.lightblueShade,
          borderRadius: Dimensions.smallRadius8,
        ),
        child: const Row(
          mainAxisAlignment: Dimensions.spacecenter,
          children: [
            Icon(
              Icons.filter_list,
              color: AppColors.blueshadE100,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "Add Filters",
              style: TextStyles.textStyle6,
            )
          ],
        )),
  );
}

/// profile screen

Widget profileConatiners(double width) {
  return Container(
    height: 100,
    width: width,
    decoration: BoxDecoration(
      borderRadius: Dimensions.smallRadius33,
      color: AppColors.clBlack,
    ),
    child: Row(
      mainAxisAlignment: Dimensions.spacestart,
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          height: 78,
          width: 34,
          decoration: BoxDecoration(
            borderRadius: Dimensions.smallRadius111,
            color: AppColors.whitegrey,
          ),
          child: Center(
              child: Image.asset(
            starIcons,
            width: 18,
            height: 18,
          )),
        ),
        const SizedBox(
          width: 8,
        ),
        const Column(
          mainAxisAlignment: Dimensions.spacecenter,
          children: [
            Row(
              children: [
                Text(
                  "4.3",
                  style: TextStyles.textStyle18,
                ),
                Icon(
                  Icons.star,
                  size: 15,
                  color: AppColors.clWhite,
                )
              ],
            ),
            Text(
              "2,211",
              style: TextStyles.textStyle1,
            ),
            Text(
              "rides",
              style: TextStyles.textStyle15,
            ),
          ],
        )
      ],
    ),
  );
}

Widget profileVerifiedContainers(double width) {
  return Container(
    height: 107,
    width: width,
    decoration: BoxDecoration(
      borderRadius: Dimensions.smallRadius33,
      color: AppColors.clBlack,
    ),
    child: Row(
      mainAxisAlignment: Dimensions.spacestart,
      children: [
        SizedBox(
          width: 15,
        ),
        Container(
          height: 78,
          width: 34,
          decoration: BoxDecoration(
            borderRadius: Dimensions.smallRadius111,
            color: AppColors.cll1A9C9C5,
          ),
          child: const Center(
              child: Icon(
            Icons.verified_user_outlined,
            color: AppColors.loghtgreen,
          )),
        ),
        const SizedBox(
          width: 8,
        ),
        const Column(
          mainAxisAlignment: Dimensions.spacecenter,
          children: [
            Row(
              children: [
                Text(
                  "KYC",
                  style: TextStyles.textStyle18,
                ),
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: 15,
                  color: AppColors.clWhite,
                )
              ],
            ),
            Text(
              "Verified",
              style: TextStyles.textStyleverification,
            ),
          ],
        )
      ],
    ),
  );
}

Widget logoutBtn({required Function() onTap, required double width}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      margin: Dimensions.padding,
      width: width,
      height: 67,
      decoration: BoxDecoration(
          color: AppColors.clBlack, borderRadius: Dimensions.smallRadius174),
      child: const Row(
        mainAxisAlignment: Dimensions.spacecenter,
        children: [
          Icon(
            Icons.logout_sharp,
            color: AppColors.redcolor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Logout",
            style: TextStyles.textStyle400,
          )
        ],
      ),
    ),
  );
}

Widget profileListTile({
  required IconData icon,
  required String title,
}) {
  return ListTile(
    leading: Icon(
      icon,
      size: 20,
      color: AppColors.whitegrey,
    ),
    title: Text(
      title,
      style: TextStyles.textStyle6,
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      size: 12,
      color: AppColors.clWhite,
    ),
  );
}

/// dashboard
///
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final VoidCallback onTap;
  final Color color1;
  final Color color2;
  final int cardIndex;
  DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.onTap,
    required this.color1,
    required this.color2,
    required this.cardIndex,
  });

  @override
  Widget build(BuildContext context) {
    final containerColor = (cardIndex % 2 == 0) ? color1 : color2;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 102,
        margin: Dimensions.buttonshomePadding,
        padding: Dimensions.commonpadding16,
        decoration: BoxDecoration(
          color: AppColors.blackishcolor,
          borderRadius: Dimensions.smallRadius16,
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: Dimensions.smallRadius111,
                color: containerColor,
              ),
              child: Center(
                  child: Icon(
                icon,
                color: AppColors.loghtgreen,
                size: 15,
              )),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: Dimensions.crossspacestart,
                children: [
                  Text(title,
                      style: TextStyle(
                        color: containerColor,
                        fontSize: 15.07,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      )),
                  Text(
                    '$value',
                    style: TextStyles.textStyleHome,
                  ),
                  Text(' $subtitle', style: TextStyles.textStyles18),
                ],
              ),
            ),
            Container(
              height: 70,
              width: 60,
              decoration: BoxDecoration(
                  color: AppColors.black9,
                  borderRadius: Dimensions.smallRadius16),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.clGrey,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget commonLine() {
  return Container(
    width: 150,
    height: 1,
    color: AppColors.lightblueShade,
  );
}

Widget commonLine2(double width) {
  return Container(
    width: width,
    height: 1,
    color: AppColors.lightblueShade,
  );
}
