part of 'character_details_bloc.dart';

abstract class CharacterDetailsState extends Equatable {
  const CharacterDetailsState();

  @override
  List<Object> get props => [];
}

class CharacterDetailsInitial extends CharacterDetailsState {}

class CharacterDetailsLoading extends CharacterDetailsState {}

class CharacterDetailsLoaded extends CharacterDetailsState {
  final Character character;

  const CharacterDetailsLoaded({required this.character});

  @override
  List<Object> get props => [character];
}

class CharacterDetailsError extends CharacterDetailsState {
  final String message;

  const CharacterDetailsError({required this.message});
  
  @override
  List<Object> get props => [message];
}
