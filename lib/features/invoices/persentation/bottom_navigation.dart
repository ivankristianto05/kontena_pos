// import 'package:flutter/material.dart';
// import 'package:kontena_pos/core/functions/cart.dart';
// import 'package:kontena_pos/core/theme/theme_helper.dart';
// import 'package:kontena_pos/core/utils/number_ui.dart';

// class BottomNavigationInvoice extends StatelessWidget {
//   // final double contentHeight;

//   Cart cart = Cart();

//   BottomNavigationInvoice({
//     super.key,
//     // required this.contentHeight,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.max,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Container(
//             height: MediaQuery.sizeOf(context).width * 0.07,
//             decoration: BoxDecoration(
//               color: theme.colorScheme.secondaryContainer,
//               border: Border.all(
//                 // right: BorderSide(
//                 color: theme.colorScheme.primary,
//                 width: 2.0,
//                 // ),
//                 // bottom: BorderSide(
//                 //   color: theme.colorScheme.surface,
//                 //   width: 1.0,
//                 // ),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Produk',
//                   style: TextStyle(color: theme.colorScheme.primary),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             height: MediaQuery.sizeOf(context).width * 0.07,
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primaryContainer,
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Voucher',
//                   style: TextStyle(color: theme.colorScheme.secondary),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           width: MediaQuery.sizeOf(context).width * 0.25,
//           height: MediaQuery.sizeOf(context).width * 0.07,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             children: [
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: cart.items.isNotEmpty
//                         ? theme.colorScheme.primary
//                         : theme.colorScheme.surface,
//                   ),
//                   child: Padding(
//                     padding:
//                         EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Bayar',
//                               style: cart.items.isNotEmpty
//                                   ? TextStyle(
//                                       color: theme.colorScheme.primaryContainer,
//                                       fontSize: 18.0,
//                                       fontWeight: FontWeight.w600,
//                                     )
//                                   : theme.textTheme.labelLarge,
//                             ),
//                             Text(
//                               '${cart.items.length} item',
//                               style: cart.items.isNotEmpty
//                                   ? TextStyle(
//                                       color: theme.colorScheme.primaryContainer,
//                                     )
//                                   : theme.textTheme.labelSmall,
//                             ),
//                           ],
//                         ),
//                         Text(
//                           numberFormat(
//                             'idr',
//                             cart.getTotal(),
//                           ),
//                           style: cart.items.isNotEmpty
//                               ? TextStyle(
//                                   color: theme.colorScheme.primaryContainer,
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.w600,
//                                 )
//                               : theme.textTheme.labelLarge,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
