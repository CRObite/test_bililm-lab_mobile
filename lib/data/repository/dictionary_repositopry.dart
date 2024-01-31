
import 'package:dio/dio.dart';
import 'package:test_bilimlab_project/domain/city.dart';
import 'package:test_bilimlab_project/domain/school.dart';

import '../../config/handleErrorResponse.dart';
import '../../domain/customResponse.dart';
import '../../domain/region.dart';
import '../../utils/AppApiUrls.dart';

class DictionaryRepository {

  Dio dio = Dio();

  DictionaryRepository() : dio = Dio() {
    dio.options = BaseOptions(
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 60 * 1000),
    );
  }

  Future<CustomResponse> getRegions(String searchText) async {
    try {
      final response = await dio.get(
        '${AppApiUrls.getRegions}',
        queryParameters: {
          "name": searchText,
        },
      );

      print(response.data);

      List<Region> regions = (response.data as List<dynamic>)
          .map((regionData) => Region.fromJson(regionData)).toList();

      return CustomResponse(200, '', regions);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getCities(int regionInd,String searchText) async {
    try {

      final response = await dio.get(
        '${AppApiUrls.getCity}',
        queryParameters: {
          "name": searchText,
          "regionId": regionInd,
        },
      );

      print(response.data);

      List<City> cities = (response.data as List<dynamic>)
          .map((cityData) => City.fromJson(cityData)).toList();

      return CustomResponse(200, '', cities);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }

  Future<CustomResponse> getSchool(int cityInd,String searchText) async {
    try {

      final response = await dio.get(
        '${AppApiUrls.getSchool}',
        queryParameters: {
          "name": searchText,
          "cityId": cityInd,
        },
      );

      print(response.data);

      List<School> schools = (response.data as List<dynamic>)
          .map((schoolData) => School.fromJson(schoolData)).toList();

      return CustomResponse(200, '', schools);

    } catch (e) {
      print(e);
      return HandleErrorResponse.handleErrorResponse(e);
    }
  }


}
