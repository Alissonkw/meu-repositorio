// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sixam_mart_store/common/widgets/custom_app_bar_widget.dart';
// import 'package:sixam_mart_store/common/widgets/custom_button_widget.dart';
// import 'package:sixam_mart_store/util/dimensions.dart';
// import 'package:sixam_mart_store/util/styles.dart';
//
// class QrMenuScreen extends StatelessWidget {
//   const QrMenuScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBarWidget(title: 'integrate_menumium_qr_code'.tr),
//
//       body: Column(children: [
//
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//             child: Column(children: [
//
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                 decoration: BoxDecoration(
//                   color: const Color(0xffF2F4FA),
//                   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                 ),
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//                   RichText(
//                     text: TextSpan(children: [
//                       TextSpan(text: 'Upgrade your restaurant with Menumium’s Smart QR Code'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color)),
//                       const TextSpan(text: '  '),
//                       TextSpan(text: 'Free For Lifetime!'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color)),
//                     ]),
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeSmall),
//
//                   Text(
//                     'Menumium is a complete restaurant management system developed by 6amTech. It helps food entrepreneurs change how their businesses run. Heres how our digital menu system helps you meet customer expectations while making management easier.'.tr,
//                     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
//                   ),
//
//                 ]),
//               ),
//
//             ]),
//           ),
//         ),
//         const SizedBox(height: Dimensions.paddingSizeLarge),
//
//         Container(
//           padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//             boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
//           ),
//           child: Row(children: [
//
//             Expanded(
//               child: Container(
//                 height: 44,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                   border: Border.all(color: Theme.of(context).primaryColor),
//                 ),
//                 child: CustomButtonWidget(
//                   buttonText: 'visit_menumium'.tr,
//                   color: Colors.transparent,
//                   textColor: Theme.of(context).primaryColor,
//                   onPressed: () {
//
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: Dimensions.paddingSizeSmall),
//
//             Expanded(
//               child: CustomButtonWidget(
//                 buttonText: 'generate_token'.tr,
//                 onPressed: () {
//
//                 },
//               ),
//             ),
//
//           ]),
//         ),
//
//       ]),
//     );
//   }
// }
