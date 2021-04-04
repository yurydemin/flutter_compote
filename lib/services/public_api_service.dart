import 'package:dio/dio.dart';
import 'package:flutter_compote/models/public_data.dart';

class PublicApiService {
  Dio _dio = Dio();

  Future<List<PublicData>> fetchPublicData() async {
    final response = await _dio
        .get('https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301');
    return response.data
        .map<PublicData>((item) => PublicData.fromJson(item))
        .toList();
  }
}
