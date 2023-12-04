

import 'package:test_bilimlab_project/data/repository/school_class_reopsitory.dart';
import 'package:test_bilimlab_project/domain/modoClass.dart';

class SchoolClassService{
  Future<List<ModoClass>> getAllModoClass() async {
    return await SchoolClassRepository().getAllModoClass();
  }
}