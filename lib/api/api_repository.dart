import 'package:rickandmortyapp/model/all_characters.dart';
import 'api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<AllCharacters> fetchAllCharactersList() {
    return provider.fetchAllCharacters();
  }

  Future<AllCharacters> fetchAllCharactersListNextPage(String? nextPageUrl) {
    return provider.fetchAllCharactersNextPage(nextPageUrl);
  }

}

class NetworkError extends Error {}