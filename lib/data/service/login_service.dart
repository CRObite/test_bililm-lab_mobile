import 'package:test_bilimlab_project/data/repository/login_repository.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class LoginService{
  Future<CustomResponse> logIn(String iin, String password) async {
    return await LoginRepository().logInByIIN(iin, password);
  }

  Future<CustomResponse> userGetMe() async {
    return await LoginRepository().userGetMe();
  }

  Future<CustomResponse> refreshToken(String token) async {
    return await LoginRepository().refreshToken(token);
  }

  Future<CustomResponse> recoverPassword(String email, String iin) async {
    return await LoginRepository().recoverPassword(email, iin);
  }

  Future<CustomResponse> deleteUser() async {
    return await LoginRepository().deleteUser();
  }

  Future<CustomResponse> checkPassword(String password) async {
    return await LoginRepository().checkPassword(password);
  }


  Future<CustomResponse> register(
      String email,
      String phoneNumber,
      String firstName,
      String? middleName,
      String lastName,
      String iin,
      String? region,
      String? city,
      String? school)  async {
    return await LoginRepository().register(
        email, phoneNumber, firstName, middleName, lastName,iin, region, city, school) ;
  }
}