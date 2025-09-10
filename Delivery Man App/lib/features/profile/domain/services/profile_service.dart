import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_bottom_sheet_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_button_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_confirmation_bottom_sheet.dart';
import 'package:sixam_mart_delivery/features/address/domain/models/record_location_body_model.dart';
import 'package:sixam_mart_delivery/features/profile/domain/models/profile_model.dart';
import 'package:sixam_mart_delivery/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:geocoding/geocoding.dart' as geo_coding;
import 'package:sixam_mart_delivery/features/profile/domain/services/profile_service_interface.dart';
import 'package:sixam_mart_delivery/util/images.dart';

class ProfileService implements ProfileServiceInterface {
  final ProfileRepositoryInterface profileRepositoryInterface;
  ProfileService({required this.profileRepositoryInterface});

  @override
  Future<ProfileModel?> getProfileInfo() async {
    return await profileRepositoryInterface.getProfileInfo();
  }

  @override
  Future<ResponseModel> updateProfile(ProfileModel userInfoModel, XFile? data, String token) async {
    return await profileRepositoryInterface.updateProfile(userInfoModel, data, token);
  }

  @override
  Future<ResponseModel> updateActiveStatus() async {
    return await profileRepositoryInterface.updateActiveStatus();
  }

  @override
  Future<void> recordWebSocketLocation(RecordLocationBodyModel recordLocationBody) async {
    await profileRepositoryInterface.recordWebSocketLocation(recordLocationBody);
  }

  @override
  Future<Response> recordLocation(RecordLocationBodyModel recordLocationBody) async {
    return await profileRepositoryInterface.recordLocation(recordLocationBody);
  }

  @override
  Future<ResponseModel> deleteDriver() async {
    return await profileRepositoryInterface.deleteDriver();
  }

  @override
  Future<String> addressPlaceMark(Position locationResult) async {
    String address;
    try{
      List<geo_coding.Placemark> addresses = await geo_coding.placemarkFromCoordinates(locationResult.latitude, locationResult.longitude);
      geo_coding.Placemark placeMark = addresses.first;
      address = '${placeMark.name}, ${placeMark.subAdministrativeArea}, ${placeMark.isoCountryCode}';
    }catch(e) {
      address = 'Unknown Location Found';
    }
    return address;
  }

  @override
  void checkPermission(Function callback) async {
    LocationPermission permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();

    while(Get.isBottomSheetOpen == true) {
      Get.back();
    }

    if(permission == LocationPermission.denied) {
      showCustomBottomSheet(
        child: CustomConfirmationBottomSheet(
          title: 'location_access_needed'.tr,
          description: 'you_denied'.tr,
          image: Images.locationAccessIcon,
          buttonWidget: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10, left: 30, right: 30),
            child: CustomButtonWidget(
              onPressed: () async {
                Get.back();
                await Geolocator.openAppSettings();
                Future.delayed(const Duration(seconds: 3), () {
                  if(GetPlatform.isAndroid) checkPermission(callback);
                });
              },
              buttonText: 'allow_location_permission'.tr,
            ),
          ),
        ),
      );
    }else if(permission == LocationPermission.deniedForever || (GetPlatform.isIOS ? false : permission == LocationPermission.whileInUse)) {
      showCustomBottomSheet(
        child: CustomConfirmationBottomSheet(
          title: 'location_access_needed'.tr,
          description: permission == LocationPermission.whileInUse ? 'you_denied'.tr : 'you_denied_forever'.tr,
          image: Images.locationAccessIcon,
          buttonWidget: Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10, left: 30, right: 30),
            child: CustomButtonWidget(
              onPressed: () async {
                Get.back();
                await Geolocator.openAppSettings();
                Future.delayed(const Duration(seconds: 3), () {
                  if(GetPlatform.isAndroid) checkPermission(callback);
                });
              },
              buttonText: 'allow_location_permission'.tr,
            ),
          ),
        ),
      );
    }else {
      callback();
    }
  }

}