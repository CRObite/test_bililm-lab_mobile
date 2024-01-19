import 'package:test_bilimlab_project/data/repository/dictionary_repositopry.dart';
import 'package:test_bilimlab_project/domain/customResponse.dart';

class DictionaryService{
  Future<CustomResponse> getRegions(String searchText) async {
    return await DictionaryRepository().getRegions(searchText);
  }

  Future<CustomResponse> getCities(int regionInd, String searchText) async {
    return await DictionaryRepository().getCities(regionInd, searchText);
  }

  Future<CustomResponse> getSchool(int cityInd, String searchText) async {
    return await DictionaryRepository().getSchool(cityInd, searchText);
  }
}