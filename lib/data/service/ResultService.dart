
import 'package:test_bilimlab_project/domain/customResponse.dart';

import '../../domain/result.dart';
import '../repository/result_repository.dart';

class ResultService{
  Future<CustomResponse> getResult() async {
    return await ResultRepository().getResult();
  }

  Future<CustomResponse> getSchoolResult() async {
    return await ResultRepository().getSchoolResult();
  }
}