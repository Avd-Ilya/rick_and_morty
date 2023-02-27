import 'package:rick_and_morty/model/character_model.dart';
import 'package:fpdart/src/either.dart';
import 'package:rick_and_morty/service/character_service.dart';

class MockCharacterService implements CharacterService {
  late Either<FormatException, List<Character>?> getCharactersResult;
  late Either<FormatException, Character?> getCharacterDetailsResult;

  @override
  Future<Either<FormatException, List<Character>?>> getCharacters(
      int? page) async {
    return getCharactersResult;
  }

  void getCharactersSuccess() {
    final List<Character> characters = [Character.empty()];
    getCharactersResult = Right(characters);
  }

  void getCharactersFailure() {
    getCharactersResult = const Left(FormatException());
  }

  @override
  Future<Either<FormatException, Character?>> getCharacterDetails(
      int id) async {
    return getCharacterDetailsResult;
  }

  void getCharacterDetailsSuccess() {
    getCharacterDetailsResult = Right(Character.empty());
  }

  void getCharacterDetailsFailure() {
    getCharacterDetailsResult = const Left(FormatException());
  }
}
