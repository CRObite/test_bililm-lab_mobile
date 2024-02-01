
import 'package:test_bilimlab_project/data/repository/balance_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class BalanceService{
  Future<CustomResponse> getBalance() async {

    return await BalanceRepository().getBalance();
  }

  Future<CustomResponse> getAllSubscription() async {
    return await BalanceRepository().getAllSubscription();
  }


  Future<CustomResponse> setSubscription(int subscriptionId) async {
    return await BalanceRepository().setSubscription(subscriptionId);
  }
}