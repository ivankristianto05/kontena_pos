import 'dart:convert';

import 'package:kontena_pos/core/utils/number_ui.dart';

Future<dynamic> printPageInv(
  String? type,
  dynamic invoice,
  dynamic configPrinter,
  dynamic configCompany,
  dynamic configPosProfile,
  dynamic configUser,
) async {
  dynamic temp = {};
  List<dynamic> doc = [];

  print('items, ${invoice['items']}');

   dynamic dataTemp = {
    'service': invoice['service'] ?? '',
    'creation': '${invoice['posting_date']} ${invoice['posting_time']}',
    'name': invoice['name'],
    'title': invoice['title'],
    'grand_total': invoice['grand_total'],
    'items':
        ((invoice['items'] != null))
            ? invoice['items']
            : [],
    'payments': ((invoice['payments'] != null))
        ? invoice['payments']
        : [],
    'vouchers': [],
    'change': 0,
    'receipt_no': invoice['name']
  };

  List<dynamic> tempHeader = [];
  List<dynamic> item = [];
  List<dynamic> voucher = [];
  List<dynamic> total = [];
  List<dynamic> payment = [];
  List<dynamic> change = [];
  List<dynamic> footer = [];

  // outlet
  try {
    String outletCode =
        (configPosProfile['name'] != null) ? configPosProfile['name'] : '';
    // String outletLine = (doc['company_address'] != null)
    //     ? doc['company_address']
    //     : '';
    // String outletCity = (dataOutlet['outlet_address_city'] != null)
    //     ? dataOutlet['outlet_address_city']
    //     : '';
    // String outletAddrs = "${outletLine}, ${outletCity}";
    // String outletContact = (dataOutlet['outlet_contact_phone'] != null)
    //     ? dataOutlet['outlet_contact_phone']
    //     : '';
    tempHeader.add({
      "key": "label",
      "style": "normal",
      "text": outletCode,
      "type": "center"
    });
    // tempHeader.add({
    //   "key": "label",
    //   "style": "normal",
    //   "text": outletAddrs,
    //   "type": "center"
    // });
    // tempHeader.add({
    //   "key": "label",
    //   "style": "normal",
    //   "text": outletContact,
    //   "type": "center"
    // });
  } catch (e) {
    print('error outlet, $e');
  }

  // reprint
  try {
    if (invoice['void_at'] == null) {
      if (type == 'reprint') {
        tempHeader.add({
          "key": "label",
          "style": "normal",
          "text": "** Reprinted **",
          "type": "center"
        });
        tempHeader.add({"key": 'line', "type": 'blank'});
      } else if (type == 'bill') {
        tempHeader.add({
          "key": "label",
          "style": "normal",
          "text": "** Bill **",
          "type": "center"
        });
        tempHeader.add({"key": 'line', "type": 'blank'});
      } else {
        tempHeader.add({"key": 'line', "type": 'blank'});
      }
    } else {
      tempHeader.add({
        "key": "label",
        "style": "normal",
        "text": "** Cancelled **",
        "type": "center"
      });
      tempHeader.add({"key": 'line', "type": 'blank'});
    }
  } catch (e) {
    print('Error reprint, $e');
  }

  String service =
      (dataTemp.containsKey('service') && (dataTemp['service'] != null))
          ? dataTemp['service']
          : '-';
  
  try {
    tempHeader.add({
      "key": "table",
      "style": "normal",
      "text": ["No", dataTemp['receipt_no']]
    });
    // DateTime parse = DateTime.parse(dataTemp['creation']);
    // String ct = DateFormat('dd-MM-yyyy, HH:mm').format(parse);
    tempHeader.add({
      "key": "table",
      "style": "normal",
      "text": [(service != '') ? service : '-', dataTemp['creation']]
    });

    if ((dataTemp['title'] != null) &&
        (dataTemp['title'] != 'Guest')) {
      // String newCust = (dataTemp['title'], '@');
      tempHeader.add({
        "key": "table",
        "style": "normal",
        "text": ["Customer", dataTemp['title']]
      });
    }

    String ksr = (configUser['name'] != null)
        ? configUser['name']
        : '';
    if (ksr != '') {
      // String newKsr =
          // strGetFirstWord(dataUser['message']['user']['detail']['name'], '@');

      tempHeader.add({
        "key": "table",
        "style": "normal",
        "text": ["Kasir", ksr]
      });
    }
    tempHeader.add({"key": "line", "type": "line"});
  } catch (e) {
    print('Error header, $e');
  }

  // CART ITEMS
  List<dynamic> tempItem = dataTemp['items'];
  List<dynamic> itemLines = [];
  item = [];

  try {
    for (int i = 0; i < tempItem.length; i++) {
      // if ((tempItem[i].containsKey('parent_addon_idx')) && (tempItem[i]['parent_addon_idx'] == null)) {
        itemLines.add({
          "key": "label",
          "style": "normal",
          "text": tempItem[i]['item_name'],
          "type": "left"
        });
        String qty = numberFormat('number_simple', tempItem[i]['qty']);
        String rate = numberFormat('idr_simple', tempItem[i]['rate']);
        String amount = numberFormat('idr_simple', tempItem[i]['amount']);
        itemLines.add({
          "key": "table",
          "style": "normal",
          "text": ["${qty} x ${rate}", amount]
        });

        List<dynamic> tempAddon = ((tempItem[i].containsKey('ui_addon')) && (tempItem[i]['ui_addon'] != null) &&
                (tempItem[i]['ui_addon'].length > 2))
            ? json.decode(tempItem[i]['ui_addon'])
            : [];

        if (tempAddon.isNotEmpty) {
          // item.add({
          //   "key": "label",
          //   "style": "normal",
          //   "type": "left",
          //   "text": "Addon"
          // });

          for (var dtAddon in tempAddon) {
            dynamic qtyA = dtAddon.containsKey('qty')
                ? (dtAddon['qty'] * tempItem[i]['qty'])
                : (1.0 * tempItem[i]['qty']);
            String qtyAddon = numberFormat('number_simple', qtyA);
            String rateAddon = numberFormat('idr_simple', dtAddon['standard_rate']);
            String amountAddon =
                numberFormat('idr_simple', (qtyA * dtAddon['standard_rate']));

            itemLines.add({
              "key": "label",
              "style": "normal",
              "text": "(+) ${dtAddon['item_name']}",
              "type": "left"
            });
            itemLines.add({
              "key": "table",
              "style": "normal",
              "text": ["    ${qtyAddon} x ${rateAddon}", amountAddon],
            });
          // }
        }
      }
    }
  } catch (e) {
    print('Error item lines, $e');
  }

   if (itemLines.length != 0) {
    item = [...item, ...itemLines];
  }

  // TOTAL
  total = [];
  try {
    String grandTotal =
            numberFormat('idr_simple', dataTemp['grand_total']);

    total.add({"key": "line", "type": "line"});
    total.add({
      "key": "table",
      "style": "large",
      "text": ["TOTAL", grandTotal]
    });
    total.add({"key": "line", "type": "line"});
  } catch (e) {
    print('Error total, $e');
  }

  // PAYMENT & CHANGE
  List<dynamic> tempPayment = dataTemp['payments'];
  payment = [];
  change = [];

  try {
    if ((tempPayment.length > 0) && (dataTemp['change'] > 0)) {
      tempPayment.forEach((dt) {
        payment.add({
          "key": "table",
          "style": "normal",
          "text": [
            dt['mode_of_payment'],
            numberFormat('idr_simple', (dt['amount'] + dataTemp['change']))
          ]
        });
      });
      change.add({
        "key": "table",
        "style": "normal",
        "text": [
          'Change',
          numberFormat('idr_simple', dataTemp['change'])
        ]
      });
    } else if (tempPayment.length > 0) {
      tempPayment.forEach((dt) {
        payment.add({
          "key": "table",
          "style": "normal",
          "text": [
            dt['mode_of_payment'],
            
                numberFormat('idr_simple', dt['amount'])
          ]
        });
      });
    }
  } catch (e) {
    print('Error payments, $e');
  }

  // FOOTER
  try {
    footer = [
      {"key": "line", "type": "blank"},
      {"key": "line", "type": "blank"},
      {
        "key": "label",
        "style": "normal",
        "text": "Thank You",
        "type": "center"
      },
      {"key": "line", "type": "blank"},
      {"key": "line", "type": "line"},
      {"key": "line", "type": "blank"},
      {"key": "cut"}
    ];
    if ((type != 'bill') & (type != 'reprint')) {
      if (tempPayment.length > 0) {
        String getPayment = tempPayment[0]['mode_of_payment'];
        if (getPayment.toLowerCase() == 'cash') {
          footer.add({"key": "openCashDrawer"});
        }
      }
    }
  } catch (e) {
    print('Error footer, $e');
  }

  if (tempHeader.length != 0) {
    doc = [...doc, ...tempHeader];
  }

  if (item.length != 0) {
    doc = [...doc, ...item];
  }

  // if (voucher.length != 0) {
  //   doc = [...doc, ...voucher];
  // }

  if (total.length != 0) {
    doc = [...doc, ...total];
  }

  if (payment.length != 0) {
    doc = [...doc, ...payment];
  }

  if (change.length != 0) {
    doc = [...doc, ...change];
  }

  if (footer.length != 0) {
    doc = [...doc, ...footer];
  }

  try {
    temp = {
      'printer': configPrinter['selectedPrinter'],
      'width': 80,
      'data': doc
    };
  } catch (e) {
    print('Error settingan printer, $e');
  }

  return temp;
}