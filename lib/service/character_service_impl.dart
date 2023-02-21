import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import '../model/character_model.dart';
import 'character_service.dart';

class CharacterServiceImpl implements CharacterService {
  @override
  Future<Either<FormatException, List<Character>?>> getCharacters(
      int? page) async {
    var client = http.Client();
    var url = Uri.parse(
        'https://rickandmortyapi.com/api/character/?page=${page ?? 1}');

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var json = response.body;
        return Right(
          responseFromJson(json).results,
        );
      } else {
        return const Left(FormatException());
      }
    } catch (_) {
      return const Left(FormatException());
    }
  }

  @override
  Future<Either<FormatException, Character?>> getCharacterDetails(
      int id) async {
    var client = http.Client();
    var url = Uri.parse('https://rickandmortyapi.com/api/character/$id');

    try {
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var json = response.body;
        return Right(characterFromJson(json));
      } else {
        return const Left(FormatException());
      }
    } catch (_) {
      return const Left(FormatException());
    }
  }
}
