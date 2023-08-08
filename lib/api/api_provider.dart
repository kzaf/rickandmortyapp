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

  Future<AllCharacters> fetchAllCharactersNextPage(String? nextPageUrl) async {
    try {
      String? urlNextPage = nextPageUrl;
      if(urlNextPage != null) {
        Response response = await dio.get(urlNextPage!);
        return AllCharacters.fromJson(response.data);        
      } else {
        return AllCharacters.withError(Strings.connectionErrorMessage);
      }
    } catch (error) {
      return AllCharacters.withError(Strings.connectionErrorMessage);
    }
  }

}