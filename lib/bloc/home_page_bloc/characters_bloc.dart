import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmortyapp/api/api_repository.dart';
import 'package:rickandmortyapp/model/all_characters.dart';

import '../../constants/strings.dart';

part 'characters_bloc_event.dart';
part 'characters_bloc_state.dart';

class CharactersBloc extends Bloc<CharactersBlocEvent, CharactersBlocState> {
  CharactersBloc() : super(CharactersBlocInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetAllCharactersList>((event, emit) async {
      try {
        emit(CharactersBlocLoading());

        final AllCharacters fetchedCharacters = await apiRepository.fetchCharacters(event.nextPageUrl);
        if(fetchedCharacters.results != null) {
          event.existingList?.addAll(fetchedCharacters.results as Iterable<Results>);
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