part of 'details_bloc.dart';

@immutable
sealed class DetailsBlocEvent extends Equatable {
  const DetailsBlocEvent();

  @override
  List<Object> get props => [];
}

class GetCharacterDetails extends DetailsBlocEvent {
  final int id;
  const GetCharacterDetails(this.id);
}
