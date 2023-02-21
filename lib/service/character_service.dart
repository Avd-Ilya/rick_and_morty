import 'package:fpdart/fpdart.dart';
import '../model/character_model.dart';

abstract class CharacterService {
  Future<Either<FormatException, List<Character>?>> getCharacters(int? page);
  Future<Either<FormatException, Character?>> getCharacterDetails(int id);
}