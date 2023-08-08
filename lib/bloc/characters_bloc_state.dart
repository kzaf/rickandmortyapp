part of 'characters_bloc.dart';

@immutable
sealed class CharactersBlocState extends Equatable {
  const CharactersBlocState();

  @override
  List<Object> get props => [];
  
}

final class CharactersBlocInitial extends CharactersBlocState {}

final class CharactersBlocLoading extends CharactersBlocState {}

final class CharactersBlocLoaded extends CharactersBlocState {
  final AllCharacters allCharacters;
  const CharactersBlocLoaded(this.allCharacters);
}

final class CharactersBlocLoadingNext extends CharactersBlocState {}

final class CharactersBlocLoadedNext extends CharactersBlocState {
  final AllCharacters allCharacters;
  const CharactersBlocLoadedNext(this.allCharacters);
}

final class CharactersBlocError extends CharactersBlocState {
  final String? message;
  const CharactersBlocError(this.message);
}
