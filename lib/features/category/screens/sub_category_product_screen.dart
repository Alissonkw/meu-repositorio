import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_store/common/widgets/custom_app_bar_widget.dart';
import 'package:sixam_mart_store/common/widgets/item_shimmer_widget.dart';
import 'package:sixam_mart_store/common/widgets/item_widget.dart';
import 'package:sixam_mart_store/features/category/controllers/category_controller.dart';
import 'package:sixam_mart_store/util/dimensions.dart';

class SubCategoryProductScreen extends StatefulWidget {
  final int subCategoryId;
  final String subCategoryName;
  const SubCategoryProductScreen({super.key, required this.subCategoryId, required this.subCategoryName});

  @override
  State<SubCategoryProductScreen> createState() => _SubCategoryProductScreenState();
}

class _SubCategoryProductScreenState extends State<SubCategoryProductScreen> {

  final ScrollController scrollController = ScrollController();
  
  @override
  void initState() {
    super.initState();

    Get.find<CategoryController>().setOffset(1);

    Get.find<CategoryController>().getSubCategoryItemList(
      Get.find<CategoryController>().offset.toString(), widget.subCategoryId,
      willUpdate: false,
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent
          && Get.find<CategoryController>().itemList != null
          && !Get.find<CategoryController>().isLoading) {
        int pageSize = (Get.find<CategoryController>().pageSize! / 10).ceil();
        if (Get.find<CategoryController>().offset < pageSize) {
          Get.find<CategoryController>().setOffset(Get.find<CategoryController>().offset+1);
          debugPrint('end of the page');
          Get.find<CategoryController>().showBottomLoader();
          Get.find<CategoryController>().getSubCategoryItemList(
            Get.find<CategoryController>().offset.toString(), widget.subCategoryId,
          );
        }
      }

    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: widget.subCategoryName),

      body: GetBuilder<CategoryController>(builder: (categoryController) {
        return SingleChildScrollView(
          child: Column(children: [

            categoryController.itemList != null ? categoryController.itemList!.isNotEmpty ? GridView.builder(
              key: UniqueKey(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.paddingSizeLarge,
                mainAxisSpacing: 0.01,
                crossAxisCount: 1,
                mainAxisExtent: 120,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: categoryController.itemList!.length,
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  child: ItemWidget(
                    item: categoryController.itemList![index],
                    index: index, length: categoryController.itemList!.length, isCampaign: false,
                    inStore: true,
                  ),
                );
              },
            ) : Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(child: Text('no_item_available'.tr)),
            ) : GridView.builder(
              key: UniqueKey(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Dimensions.paddingSizeLarge,
                mainAxisSpacing: 0.01,
                crossAxisCount: 1,
                mainAxisExtent: 120,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              itemBuilder: (context, index) {
                return ItemShimmerWidget(
                  isEnabled: categoryController.itemList == null, hasDivider: index != 19,
                );
              },
            ),

            categoryController.isLoading ? Center(child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
            )) : const SizedBox(),
          ]),
        );
      }),
    );
  }
}
