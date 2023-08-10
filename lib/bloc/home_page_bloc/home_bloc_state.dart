part of 'home_bloc.dart';

@immutable
sealed class CharactersBlocState extends Equatable {
  const CharactersBlocState();

  @override
  List<Object> get props => [];
  
}

final class CharactersBlocInitial extends CharactersBlocState {}

final class CharactersBlocLoading extends CharactersBlocState {}

final class CharactersBlocLoaded extends CharactersBlocState {
  final List<Results>? allCharacters;
  final String? nextPageUrl;
  const CharactersBlocLoaded(this.allCharacters, this.nextPageUrl);
}

final class CharactersBlocError extends CharactersBlocState {
  final String? message;
  const CharactersBlocError(this.message);
}
