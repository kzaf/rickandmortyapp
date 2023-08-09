import 'package:rickandmortyapp/model/all_characters.dart';
import 'api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<AllCharacters> fetchCharacters(String? nextPageUrl) {
    return provider.fetchCharacters(nextPageUrl);
  }

}

class NetworkError extends Error {}