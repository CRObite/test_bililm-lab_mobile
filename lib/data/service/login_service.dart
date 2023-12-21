import 'package:test_bilimlab_project/data/repository/login_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';
import 'package:test_bilimlab_project/domain/testUser.dart';

class LoginService{
  Future<CustomResponse> logIn(String iin, String password) async {
    return await LoginRepository().logInByIIN(iin, password);
  }

  Future<TestUser?> userGetMe() async {
    return await LoginRepository().userGetMe();
  }
}