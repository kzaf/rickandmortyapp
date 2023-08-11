import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmortyapp/api/api_repository.dart';

import '../../constants/strings.dart';
import '../../api/model/details_character.dart';

part 'details_bloc_event.dart';
part 'details_bloc_state.dart';

class DetailsBloc extends Bloc<DetailsBlocEvent, DetailsBlocState> {
  DetailsBloc() : super(DetailsBlocInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetCharacterDetails>((event, emit) async {
      try {
        emit(DetailsBlocLoading());

        final DetailsCharacter fetchedCharacterDetails = await apiRepository.fetchDetails(event.id);

        emit(DetailsBlocLoaded(fetchedCharacterDetails));

        if (fetchedCharacterDetails.error != null) {
          emit(DetailsBlocError(fetchedCharacterDetails.error ?? Strings.genericErrorMessage));
        }

      } on NetworkError {
        emit(DetailsBlocError(Strings.fetchErrorMessage));
      }
    });
    
  }
}
