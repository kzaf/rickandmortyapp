import 'package:rickandmortyapp/api/model/all_characters.dart';
import 'package:rickandmortyapp/api/model/episode.dart';
import 'model/details_character.dart';
import 'api_provider.dart';

class ApiRepository {
  final provider = ApiProvider();

  Future<AllCharacters> fetchCharacters(String? nextPageUrl) =>
      provider.fetchCharacters(nextPageUrl);

  Future<DetailsCharacter> fetchDetails(int id) => provider.fetchDetails(id);

  Future<Episode> fetchEpisodeDetails(String? url) =>
      provider.fetchEpisodeDetails(url!);
}

class NetworkError extends Error {}
