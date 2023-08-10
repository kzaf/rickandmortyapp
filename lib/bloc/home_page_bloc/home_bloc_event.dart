part of 'home_bloc.dart';

@immutable
sealed class CharactersBlocEvent extends Equatable{
  const CharactersBlocEvent();

  @override
  List<Object> get props => [];
}

class GetAllCharactersList extends CharactersBlocEvent {
  final List<Results>? existingList;
  final String? nextPageUrl;
  const GetAllCharactersList(this.existingList, this.nextPageUrl);
}