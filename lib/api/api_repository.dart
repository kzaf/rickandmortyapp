import 'package:rickandmortyapp/model/all_characters.dart';
import '../model/details_character.dart';
import 'api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<AllCharacters> fetchCharacters(String? nextPageUrl) => provider.fetchCharacters(nextPageUrl);

  Future<DetailsCharacter> fetchDetails(int id) => provider.fetchDetails(id);

}

class NetworkError extends Error {}