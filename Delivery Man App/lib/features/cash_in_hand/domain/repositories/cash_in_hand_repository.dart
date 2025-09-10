import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/earning_report_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/repositories/cash_in_hand_repository_interface.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/util/app_constants.dart';

class CashInHandRepository implements CashInHandRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CashInHandRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future<ResponseModel> makeCollectCashPayment(double amount, String paymentGatewayName) async {
    ResponseModel responseModel;
    Response response = await apiClient.postData(AppConstants.makeCollectedCashPaymentUri, {
      "amount": amount,
      "payment_gateway": paymentGatewayName,
      "callback": RouteHelper.success,
      "token": _getUserToken(),
    }, handleError: false);

    if (response.statusCode == 200) {
      String redirectUrl = response.body['redirect_link'];
      Get.back();
      if(GetPlatform.isWeb) {
        // html.window.open(redirectUrl,"_self");
      } else{
        Get.toNamed(RouteHelper.getPaymentRoute(redirectUrl));
      }
      responseModel = ResponseModel(true, response.body.toString());
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<List<Transactions>?> getList() async {
    List<Transactions>? transactions;
    Response response = await apiClient.getData('${AppConstants.walletPaymentListUri}?token=${_getUserToken()}');
    if(response.statusCode == 200) {
      transactions = [];
      WalletPaymentModel walletPaymentModel = WalletPaymentModel.fromJson(response.body);
      transactions.addAll(walletPaymentModel.transactions!);
    }
    return transactions;
  }

  @override
  Future<List<Transactions>?> getWalletProvidedEarningList() async {
    List<Transactions>? walletProvidedTransactions;
    Response response = await apiClient.getData('${AppConstants.walletProvidedEarningListUri}?token=${_getUserToken()}');
    if(response.statusCode == 200) {
      walletProvidedTransactions = [];
      WalletPaymentModel walletPaymentModel = WalletPaymentModel.fromJson(response.body);
      walletProvidedTransactions.addAll(walletPaymentModel.transactions!);
    }
    return walletProvidedTransactions;
  }

  @override
  Future<ResponseModel> makeWalletAdjustment() async {
    ResponseModel responseModel;
    Response response = await apiClient.postData(AppConstants.makeWalletAdjustmentUri, {'token': _getUserToken()}, handleError: false);
    if(response.statusCode == 200) {
      responseModel = ResponseModel(true, 'wallet_adjustment_successfully'.tr);
    }else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  String _getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  @override
  Future<EarningReportModel?> getEarningReport({String? offset, String? type, String? startDate, String? endDate}) async {
    EarningReportModel? earningReportModel;
    Response response;

    if(startDate != null && endDate != null) {
      response = await apiClient.getData('${AppConstants.earningReportUri}?limit=10&offset=$offset&type=$type&start_date=$startDate&end_date=$endDate&token=${_getUserToken()}');
    } else {
      response = await apiClient.getData('${AppConstants.earningReportUri}?limit=10&offset=$offset&type=$type&start_date=&end_date=&token=${_getUserToken()}');
    }

    if(response.statusCode == 200) {
      earningReportModel = EarningReportModel.fromJson(response.body);
    }
    return earningReportModel;
  }

  @override
  Future<Response> downloadEarningInvoice({required int dmId}) async {
    Response response = await apiClient.getData('${AppConstants.earningReportInvoiceUri}/$dmId', handleError: false);
    return response;
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(int? id) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body) {
    throw UnimplementedError();
  }

}