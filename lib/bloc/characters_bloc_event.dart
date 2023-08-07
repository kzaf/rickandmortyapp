part of 'characters_bloc.dart';

@immutable
sealed class CharactersBlocEvent extends Equatable{
  const CharactersBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAllCharactersList extends CharactersBlocEvent {}