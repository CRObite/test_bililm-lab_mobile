
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/config/handleErrorResponse.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/subscription.dart';
import 'package:test_bilimlab_project/domain/wallet.dart';
import '../../domain/currentUser.dart';
import '../../utils/AppApiUrls.dart';

class BalanceRepository {

  Dio dio = Dio();

  BalanceRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getBalance() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.getBalance}',
      );

      print(response.data);

      Wallet wallet = Wallet.fromJson(response.data);

      return CustomResponse(200, '', wallet);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getAllSubscription() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${CurrentUser.currentTestUser?.accessToken}';

      final response = await dio.get(
        '${AppApiUrls.subscription}',
      );

      print(response.data);

      List<Subscription> subscriptions = (response.data as List<dynamic>)
          .map((subscriptionData) => Subscription.fromJson(subscriptionData)).toList();
      return CustomResponse(200, '', subscriptions);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

}
