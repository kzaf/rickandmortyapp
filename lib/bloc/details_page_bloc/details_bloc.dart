import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rickandmortyapp/api/api_repository.dart';

import '../../api/model/episode.dart';
import '../../constants/strings.dart';
import '../../api/model/details_character.dart';
import '../../ui/ui_model/details_page_item.dart';

part 'details_bloc_event.dart';
part 'details_bloc_state.dart';

class DetailsBloc extends Bloc<DetailsBlocEvent, DetailsBlocState> {
  DetailsBloc() : super(DetailsBlocInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetCharacterDetails>((event, emit) async {
      try {
        emit(DetailsBlocLoading());

        final DetailsCharacter fetchedCharacterDetails = await apiRepository.fetchDetails(event.id);
        DetailsItem detailsItems = 
          DetailsItem(
            name: fetchedCharacterDetails.name ?? Strings.unknown,
            status: fetchedCharacterDetails.status ?? Strings.unknown,
            species: fetchedCharacterDetails.species ?? Strings.unknown,
            type: fetchedCharacterDetails.type ?? Strings.unknown,
            gender: fetchedCharacterDetails.gender ?? Strings.unknown,
            originName: fetchedCharacterDetails.origin?.name ?? Strings.unknown,
            locationName: fetchedCharacterDetails.location?.name ?? Strings.unknown,
            image: fetchedCharacterDetails.image ?? Strings.imageNotFound,
            episodes: fetchedCharacterDetails.episode ?? []
        );

        List<String> updatedEpisodes = await Future.wait(
          detailsItems.episodes.map((episode) async {
            final Episode episodeName = await apiRepository.fetchEpisodeDetails(episode);
            return episodeName.name ?? Strings.unknown;
          }),
        );
        detailsItems.episodes = updatedEpisodes;

        emit(DetailsBlocLoaded(detailsItems));

        if (fetchedCharacterDetails.error != null) {
          emit(DetailsBlocError(fetchedCharacterDetails.error ?? Strings.genericErrorMessage));
        }

      } on NetworkError {
        emit(DetailsBlocError(Strings.fetchErrorMessage));
      }
    });
    
  }
}
