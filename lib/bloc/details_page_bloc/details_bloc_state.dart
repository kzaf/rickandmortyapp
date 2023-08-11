part of 'details_bloc.dart';

@immutable
sealed class DetailsBlocState extends Equatable {
  const DetailsBlocState();

  @override
  List<Object> get props => [];
  
}

final class DetailsBlocInitial extends DetailsBlocState {}

final class DetailsBlocLoading extends DetailsBlocState {}

final class DetailsBlocLoaded extends DetailsBlocState {
  final DetailsCharacter characterDetails;
  const DetailsBlocLoaded(this.characterDetails);
}

final class DetailsBlocError extends DetailsBlocState {
  final String message;
  const DetailsBlocError(this.message);
}
