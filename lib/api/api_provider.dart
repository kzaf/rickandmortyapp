import 'package:dio/dio.dart';
import 'package:rickandmortyapp/model/all_characters.dart';
import '../constants/strings.dart';
import '../model/details_character.dart';

class ApiProvider {
  final Dio dio = Dio();

  Future<AllCharacters> fetchCharacters(String? nextPageUrl) async {
    try {
      String? urlNextPage = nextPageUrl;
      if(urlNextPage != null) {
        if(urlNextPage == "") {
          Response response = await dio.get(Strings.allCharactersUrl);
          return AllCharacters.fromJson(response.data); 
        } else {
          Response response = await dio.get(urlNextPage);
          return AllCharacters.fromJson(response.data);
        }
      } else {
        return AllCharacters.withError(Strings.connectionErrorMessage);
      }
    } catch (error) {
      return AllCharacters.withError(Strings.connectionErrorMessage);
    }
  }

  Future<DetailsCharacter> fetchDetails(int id) async {
    try {
      Response response = await dio.get("${Strings.allCharactersUrl}$id");
      return DetailsCharacter.fromJson(response.data); 
    } catch (error) {
      return DetailsCharacter.withError(Strings.connectionErrorMessage);
    }
  }

}