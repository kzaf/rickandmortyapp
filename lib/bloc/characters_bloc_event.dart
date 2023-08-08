part of 'characters_bloc.dart';

@immutable
sealed class CharactersBlocEvent extends Equatable{
  const CharactersBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAllCharactersList extends CharactersBlocEvent {}
class GetAllCharactersListNext extends CharactersBlocEvent {
  final String? nextPageUrl;
  const GetAllCharactersListNext(this.nextPageUrl);
}