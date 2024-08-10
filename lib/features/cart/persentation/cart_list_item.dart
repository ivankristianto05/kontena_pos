import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/widgets/list_cart.dart';

class CardListItem extends StatelessWidget {
  final List<CartItem> cartData;

  CardListItem({
    Key? key,
    required this.cartData,
  }) : super(key: key);

  // Map<String, dynamic> item;
  int totalAddon = 0;
  int totalAddonCheckout = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top -
                130,
            child: ListView.builder(
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                final itemData = cartData[index];
                String note = getPreferenceText(itemData.preference);
                String addon2 = '';
                String catatan = '';
                totalAddon = 0;

                if (itemData.notes != null) {
                  catatan = itemData.notes.toString();
                }

                if (itemData.addons != null) {
                  itemData.addons!.forEach((key, value) {
                    String itemName = value["itemName"] as String;
                    String price = value["price"];

                    addon2 +=
                        "$itemName - (${numberFormat('idr', double.parse(price))})\n";
                    totalAddon += double.parse(price).toInt();
                  });
                }

                return Container(
                  child: ListCart(
                    title: "${itemData.qty}x ${itemData.name}",
                    addon: addon2,
                    catatan: catatan,
                    titleStyle: CustomTextStyles.labelLargeBlack,
                    price: numberFormat(
                        'idr', itemData.qty * (itemData.price + totalAddon)),
                    priceStyle: CustomTextStyles.labelLargeBlack,
                    labelStyle: CustomTextStyles.bodySmallBluegray300,
                    editLabelStyle: CustomTextStyles.bodySmallOrange600,
                    padding: EdgeInsets.all(16),
                    note: note,
                    lineColor: appTheme.gray200,
                    secondaryStyle: CustomTextStyles.bodySmallGray,
                    onTap: () => onTapItem(context, index, itemData),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void onTapItem(BuildContext context, int index, CartItem itemData) {}
}
