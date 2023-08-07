import 'package:dio/dio.dart';
import 'package:rickandmortyapp/model/all_characters.dart';
import '../constants/strings.dart';

class ApiProvider {
  final Dio dio = Dio();

  Future<AllCharacters> fetchAllCharacters() async {
    try {
      Response response = await dio.get(Strings.allCharactersUrl);
      return AllCharacters.fromJson(response.data);
    } catch (error) {
      return AllCharacters.withError(Strings.connectionErrorMessage);
    }
  }

}