part of 'character_details_bloc.dart';

abstract class CharacterDetailsEvent extends Equatable {
  const CharacterDetailsEvent();

  @override
  List<Object> get props => [];
}

class NeedCharacter extends CharacterDetailsEvent {
  final int characterId;

  const NeedCharacter({required this.characterId});

  @override
  List<Object> get props => [characterId];
}
