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
import '../MODELS/Sales_Model_Class.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.clBlack,
      appBar: AppBar(
        backgroundColor: AppColors.clBlack,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.clWhite,
          ),
          onPressed: () {
            back(context);
          },
        ),
        title: const Text("Filters", style: TextStyles.textStyle7),
        centerTitle: false,
        actions: [
          Padding(
            padding: Dimensions.allpaddings,
            child: Consumer<SalesProvider>(builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  value.dateWiseFilteredSalesList();
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      color: AppColors.locationColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Filter", style: TextStyles.textStyle3)
                  ],
                ),
              );
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            commonLine2(width),
            const SizedBox(
              height: 15,
            ),
            Consumer<SalesProvider>(builder: (context, value, child) {
              return monthConatiner(
                onMonthChanged: (String newMonth) {
                  value.updateSelectedMonth(newMonth);
                },
                selectedMonth: value.selectedMonth,
                months: value.months,
              );
            }),
            Consumer<SalesProvider>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: Dimensions.spacecenter,
                children: [
                  calenderConatiner(
                    onTap: () {
                      value.selectDate(context);
                    },
                    ct: value.startdateController,
                  ),
                  calenderConatiner(
                    onTap: () {
                      value.endSelectDate(context);
                    },
                    ct: value.enddateController,
                  ),
                ],
              );
            }),
            const SizedBox(
              height: 8,
            ),
            commonLine2(width),
            Consumer<MainProvider>(builder: (context, value, child) {
              return Padding(
                padding: Dimensions.padding,
                child: SizedBox(
                  height: 60,
                  width: width,
                  child: ListView.builder(
                    itemCount: value.filters.length,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return filterContainer(
                        onTap: () {
                          value.updateSelectedIndex(
                              index); // Update selected index
                        },
                        text: value.filters[index],
                        isSelected: value.selectedFilterIndex == index,
                      );
                    },
                  ),
                ),
              );
            }),
            Consumer<SalesProvider>(
              builder: (context, salesProvider, child) {
                return container(
                  width: width,
                  text: 'Customer',
                  customers: (SalesData selectedCustomer) {
                    salesProvider
                        .selectCustomer(selectedCustomer); // Notify provider
                  },
                  selectedItem:
                      salesProvider.selectedCustomer, // Bind selected item
                  names: salesProvider.salesData, // Populate dropdown items
                );
              },
            ),
            Consumer<SalesProvider>(
              builder: (context, value, child) {
                return value.isLoading
                    ? const CircularProgressIndicator(color: AppColors.clWhite)
                    : value.datewisefiltersalesList.isEmpty
                        ? const SizedBox(
                            height: 200,
                            child: Center(
                                child: Text(
                              "No Sales Data Found",
                              style: TextStyles.textStyle1,
                            )))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: value.datewisefiltersalesList.length,
                            itemBuilder: (context, index) {
                              final sale = value.datewisefiltersalesList[index];
                              return Container(
                                  margin: Dimensions.padding,
                                  width: width,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: Dimensions.allpaddings,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                        text: "# ",
                                                        style: TextStyles
                                                            .textStyles18,
                                                      ),
                                                      TextSpan(
                                                        text: sale
                                                            .voucherNo, // Replace or concatenate as needed
                                                        style: TextStyles
                                                            .textStyle6,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(sale.customerName,
                                                    style:
                                                        TextStyles.textStyles6),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  sale.status,
                                                  style: sale.status !=
                                                          'Invoiced'
                                                      ? TextStyles.textStyle12
                                                      : TextStyles.textStyle13,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      const TextSpan(
                                                        text: "SAR.",
                                                        style: TextStyles
                                                            .textStyles18,
                                                      ),
                                                      TextSpan(
                                                        text: sale.grandTotal
                                                            .toString(), // Replace or concatenate as needed
                                                        style: TextStyles
                                                            .textStyle4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      commonLine()
                                    ],
                                  ));
                            },
                          );
              },
            )
          ],
        ),
      ),
    );
  }
}
