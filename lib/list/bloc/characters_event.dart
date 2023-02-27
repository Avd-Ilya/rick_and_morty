part of 'characters_bloc.dart';

@immutable
abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object?> get props => [];
}

class NeedCharacters extends CharactersEvent {}

class CharactersShouldShowDetails extends CharactersEvent {
  const CharactersShouldShowDetails({required this.characterId});
  final int characterId;

  @override
  List<Object?> get props => [characterId];
}