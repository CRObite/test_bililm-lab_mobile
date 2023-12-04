
import 'package:test_bilimlab_project/data/repository/subject_repository.dart';
import '../../domain/entSubject.dart';

class SubjectService{
  Future<List<EntSubject>> getEntAllSubject() async {
    return await SubjectRepository().getAllEntSubject();
  }

  Future<List<EntSubject>> getEntSubjectInMSS(int subIndex) async {
    return await SubjectRepository().getEntSubjectInMSS(subIndex);
  }
}