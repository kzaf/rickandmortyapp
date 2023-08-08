import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmortyapp/api/api_repository.dart';
import 'package:rickandmortyapp/model/all_characters.dart';

import '../constants/strings.dart';

part 'characters_bloc_event.dart';
part 'characters_bloc_state.dart';

class CharactersBloc extends Bloc<CharactersBlocEvent, CharactersBlocState> {
  CharactersBloc() : super(CharactersBlocInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetAllCharactersList>((event, emit) async {
      try {
        emit(CharactersBlocLoading());
        final allCharacters = await apiRepository.fetchAllCharactersList();
        emit(CharactersBlocLoaded(allCharacters));
        if (allCharacters.error != null) {
          emit(CharactersBlocError(allCharacters.error));
        }
      } on NetworkError {
        emit(CharactersBlocError(Strings.fetchErrorMessage));
      }
    });

    on<GetAllCharactersListNext>((event, emit) async {
      try {
        emit(CharactersBlocLoadingNext());
        final allCharacters = await apiRepository.fetchAllCharactersListNextPage(event.nextPageUrl);
        emit(CharactersBlocLoadedNext(allCharacters));
        if (allCharacters.error != null) {
          emit(CharactersBlocError(allCharacters.error));
        }
      } on NetworkError {
        emit(CharactersBlocError(Strings.fetchErrorMessage));
      }
    });
    
  }
}
