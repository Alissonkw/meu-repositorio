import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/earning_report_model.dart';
import 'package:sixam_mart_delivery/helper/date_converter_helper.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';

class EarningHistoryBottomSheet extends StatelessWidget {
  final Data? data;
  const EarningHistoryBottomSheet({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    final orderWiseTotalEarning = (data?.dmTips ?? 0) + (data?.originalDeliveryCharge ?? 0);
    final deliveryFee = data?.originalDeliveryCharge ?? 0;
    final deliveryTip = data?.dmTips ?? 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Container(
          height: 5, width: 50,
          margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ),
        ),

        Text(
          'earning_details'.tr,
          style: robotoBold.copyWith(color: const Color(0xff313F38), fontSize: Dimensions.fontSizeExtraLarge)
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),

        Text(PriceConverterHelper.convertPrice(orderWiseTotalEarning), style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge + 2, color: Theme.of(context).primaryColor)),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: 'order_id'.tr, style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withValues(alpha: 0.5))),
              TextSpan(text: ': ', style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withValues(alpha: 0.5))),
              TextSpan(text: data?.order?.id.toString(), style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color)),
            ],
          ),
        ),

        Text(DateConverterHelper.utcToDateTime(data!.createAt!), style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

        Text('${'pay_by'.tr}: ${data?.order?.paymentMethod?.tr}'.replaceAll('_', ' '), style: robotoRegular.copyWith(color: Theme.of(context).hintColor)),

        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                color: const Color(0xff313F38).withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              child: Column(children: [

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('delivery_fee'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge)),

                  Text(PriceConverterHelper.convertPrice(deliveryFee), style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge)),
                ]),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('delivery_tips'.tr, style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge)),

                  Text(PriceConverterHelper.convertPrice(deliveryTip), style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeLarge)),
                ]),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(
                  width: double.infinity, height: 1,
                  margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  color: Theme.of(context).disabledColor.withValues(alpha: 0.3),
                ),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('total'.tr, style: robotoBold.copyWith(color: const Color(0xff313F38), fontSize: Dimensions.fontSizeLarge)),

                  Text(PriceConverterHelper.convertPrice(orderWiseTotalEarning), style: robotoBold.copyWith(color: const Color(0xff313F38), fontSize: Dimensions.fontSizeLarge)),
                ]),

              ]),
            ),
          ]),
        ),

      ]),
    );
  }
}
