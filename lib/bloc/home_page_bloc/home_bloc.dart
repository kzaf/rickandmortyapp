import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmortyapp/api/api_repository.dart';
import 'package:rickandmortyapp/api/model/all_characters.dart';
import 'package:rickandmortyapp/ui/ui_model/home_list_item.dart';

import '../../constants/strings.dart';
import '../../api/model/episode.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class CharactersBloc extends Bloc<CharactersBlocEvent, CharactersBlocState> {
  CharactersBloc() : super(CharactersBlocInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetAllCharactersList>((event, emit) async {
      try {
        emit(CharactersBlocLoading());
        
        final AllCharacters fetchedCharacters = await apiRepository.fetchCharacters(event.nextPageUrl);
        List<HomeListItem>? homeListItems = fetchedCharacters.results?.map((element) {
          return HomeListItem(
            name: element.name,
            status: element.status,
            species: element.species,
            lastLocation: element.location?.name,
            firstLocation: element.episode?.first,
            image: element.image,
          );
        }).toList();

        await Future.forEach(homeListItems as Iterable<HomeListItem?>, (homeListItem) async {
          final Episode episode = await apiRepository.fetchEpisodeDetails(homeListItem?.firstLocation);
          homeListItem?.firstLocation = episode.name;
        });

        if(fetchedCharacters.results != null) {
          event.existingList?.addAll(homeListItems as Iterable<HomeListItem>);
        }
        emit(CharactersBlocLoaded(event.existingList, fetchedCharacters.info?.next));

        if (fetchedCharacters.error != null) {
          emit(CharactersBlocError(fetchedCharacters.error));
        }

      } on NetworkError {
        emit(CharactersBlocError(Strings.fetchErrorMessage));
      }
    });
    
  }
}
