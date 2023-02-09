import '../model/character_model.dart';

abstract class CharacterService {
  Future<List<Character>?> getCharacters(int? page);
  Future<Character?> getCharacterDetails(int id);
}