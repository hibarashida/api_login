import 'package:cabzing_driver_app_hiba/CONSTANTS/dimentions.dart';
import 'package:cabzing_driver_app_hiba/CONSTANTS/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CONSTANTS/Call_Functions.dart';
import '../CONSTANTS/Text_Style.dart';
import '../CONSTANTS/my_colors.dart';
import '../PROVIDER/dashboard_provider.dart';
import 'Filter_Screen.dart';

class SaleListScreen extends StatelessWidget {
  const SaleListScreen({super.key});

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
        title: const Text("Invoices", style: TextStyles.textStyle7),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: 1,
            color: AppColors.lightblueShade,
          ),
          Consumer<SalesProvider>(builder: (context, value, child) {
            return Padding(
              padding: Dimensions.buttonspacePadding,
              child: Row(
                mainAxisAlignment: Dimensions.spacespaceEvenly,
                children: [
                  searchFiled(
                    onChanged: (query) {
                      value.setSearchQuery(query);
                    },
                    width: width / 1.9,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  filtersBtn(
                    onTap: () {
                      callNext(context, const FilterScreen());
                    },
                    width: width / 2.8,
                  ),
                ],
              ),
            );
          }),
          Container(
            width: width,
            height: 1,
            color: AppColors.lightblueShade,
          ),
          Expanded(
            child: Consumer<SalesProvider>(
              builder: (context, value, child) {
                return value.isLoading
                    ? const CircularProgressIndicator(color: AppColors.clWhite)
                    : value.filteredSalesList.isEmpty
                        ? const Center(child: Text("No Sales Data Found...",style: TextStyles.textStyle1,))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: value.filteredSalesList.length,
                            itemBuilder: (context, index) {
                              final sale = value.filteredSalesList[index];
                              return Container(
                                margin: Dimensions.buttonsPadding,
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
                                                      style:
                                                          TextStyles.textStyle6,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(sale.customerName,
                                                  style: TextStyles.textStyles6),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                sale.status,
                                                style: sale.status != 'Invoiced'
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
                                                      text: sale.totalTax
                                                          .toString(), // Replace or concatenate as needed
                                                      style:
                                                          TextStyles.textStyle4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 150,
                                      height: 1,
                                      color: AppColors.lightblueShade,
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
              },
            ),
          )
        ],
      ),
    );
  }
}
