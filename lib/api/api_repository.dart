import 'package:rickandmortyapp/model/all_characters.dart';
import 'api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<AllCharacters> fetchAllCharactersList() {
    return provider.fetchAllCharacters();
  }
}

class NetworkError extends Error {}