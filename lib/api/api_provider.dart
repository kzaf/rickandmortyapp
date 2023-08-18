import 'package:dio/dio.dart';
import 'package:rickandmortyapp/api/model/all_characters.dart';
import 'package:rickandmortyapp/api/model/episode.dart';
import '../constants/strings.dart';
import 'model/details_character.dart';

class ApiProvider {
  final Dio dio = Dio();

  Future<AllCharacters> fetchCharacters(String? nextPageUrl) async {
    try {
      String? urlNextPage = nextPageUrl;
      if (urlNextPage != null) {
        if (urlNextPage == "") {
          Response response =
              await dio.get("${Strings.baseUrl}${Strings.charactersRoute}");
          return AllCharacters.fromJson(response.data);
        } else {
          Response response = await dio.get(urlNextPage);
          return AllCharacters.fromJson(response.data);
        }
      } else {
        return AllCharacters.withError(Strings.fetchedAllMessage);
      }
    } catch (error) {
      return AllCharacters.withError(Strings.connectionErrorMessage);
    }
  }

  Future<DetailsCharacter> fetchDetails(int id) async {
    try {
      Response response =
          await dio.get("${"${Strings.baseUrl}${Strings.charactersRoute}"}$id");
      return DetailsCharacter.fromJson(response.data);
    } catch (error) {
      return DetailsCharacter.withError(Strings.connectionErrorMessage);
    }
  }

  Future<Episode> fetchEpisodeDetails(String url) async {
    try {
      Response response = await dio.get(url);
      return Episode.fromJson(response.data);
    } catch (error) {
      return Episode.withError(Strings.connectionErrorMessage);
    }
  }
}
