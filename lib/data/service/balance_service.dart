
import 'package:test_bilimlab_project/data/repository/balance_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class BalanceService{
  Future<CustomResponse> getBalance() async {
    return await BalanceRepository().getBalance();
  }
}