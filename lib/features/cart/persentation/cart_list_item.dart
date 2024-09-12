import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kontena_pos/core/functions/cart.dart';
import 'package:kontena_pos/core/theme/custom_text_style.dart';
import 'package:kontena_pos/core/theme/theme_helper.dart';
import 'package:kontena_pos/core/utils/number_ui.dart';
import 'package:kontena_pos/features/cart/persentation/add_to_cart.dart';
import 'package:kontena_pos/widgets/list_cart.dart';

class CardListItem extends StatefulWidget {
  // final List<CartItem> cartData;

  CardListItem({
    Key? key,
    // required this.cartData,
  }) : super(key: key);

  @override
  _CardListItem createState() => _CardListItem();
}

class _CardListItem extends State<CardListItem> {
  // Map<String, dynamic> item;
  int totalAddon = 0;
  int totalAddonCheckout = 0;
  Cart cart = Cart();
  late List<CartItem> cartData;

  @override
  void initState() {
    super.initState();
    cartData = cart.getAllItemCart();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: ListView.builder(
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                final itemData = cartData[index];

                String addon2 = '';
                String catatan = '';
                String preference = '';
                totalAddon = 0;
                List<dynamic> addons = [];

                if (itemData.notes != null) {
                  catatan = itemData.notes.toString();
                }

                if (itemData.addon!.isNotEmpty) {
                  itemData.addon!.forEach((value) {
                    addons.add({
                      'name': value['nama_menu'],
                      'qty': value['qty'],
                      'price': numberFormat('idr', value['harga']),
                    });
                    // String itemName = value["itemName"] as String;
                    // String price = value["price"];

                    // addon2 +=
                    //     "$itemName - (${numberFormat('idr', double.parse(price))})\n";
                    totalAddon +=
                        (double.parse(value['harga'].toString()).toInt() *
                            double.parse(value['qty'].toString()).toInt());
                  });
                }

                if (itemData.pref != null) {
                  int i = 1;
                  itemData.pref?.forEach((element) {
                    preference += "${element['type']}: ${element['name']}";
                    if (i < itemData.pref!.length) {
                      preference += ", ";
                    }
                    i++;
                  });
                }

                return ListCart(
                  title: "${itemData.itemName} (${itemData.qty})",
                  subtitle: itemData.variant.toString(),
                  // addon: addon2,
                  addons: addons,
                  qty: itemData.qty.toString(),
                  catatan: preference,
                  titleStyle: CustomTextStyles.labelLargeBlack,
                  price: numberFormat('idr', itemData.price),
                  total: numberFormat(
                      'idr', itemData.qty * (itemData.price + totalAddon)),
                  priceStyle: CustomTextStyles.labelLargeBlack,
                  labelStyle: CustomTextStyles.bodySmallBluegray300,
                  editLabelStyle: CustomTextStyles.bodySmallPrimary,
                  padding: EdgeInsets.all(16),
                  note: itemData.notes,
                  lineColor: appTheme.gray200,
                  secondaryStyle: CustomTextStyles.bodySmallGray,
                  onTap: () => onTapItem(context, index, itemData),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void onTapItem(BuildContext context, int index, CartItem itemData) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: false,
      backgroundColor: const Color(0x8A000000),
      barrierColor: const Color(0x00000000),
      context: context,
      builder: (context) {
        dynamic item = {
          'index': index,
          'id': itemData.id,
          'id_menu': itemData.name,
          'nama_menu': itemData.itemName,
          'id_varian': itemData.variantId,
          'nama_varian': itemData.variant,
          'harga_varian': itemData.variantPrice,
          'pref': itemData.pref,
          'notes': itemData.notes,
          'addon': itemData.addon,
          'qty': itemData.qty,
        };
        print('check --data addon, ${itemData.addon}');
        return Padding(
          padding: MediaQuery.viewInsetsOf(context),
          // child: ItemDetailsDialog(
          //   name: item['nama_menu'],
          //   price: int.parse(item['harga'].toString()),
          //   idMenu: item['id_menu'],
          //   type: item['type'],
          //   onAddToCart: (item) {},
          // ),
          child: AddToCart(
            dataMenu: item,
            isNew: false,
          ),
        );
      },
    ).then((value) => {print('check value, $value')});
  }
}
