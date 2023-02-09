import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/character_model.dart';
import 'character_service.dart';

class CharacterServiceImpl implements CharacterService{

  @override
  Future<List<Character>?> getCharacters(int? page) async {
    var client = http.Client();

    var url = Uri.parse('https://rickandmortyapi.com/api/character/?page=${page ?? 1}');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return responseFromJson(json).results;
    } else {
      debugPrint('error - ${response.statusCode}');
    }
    return null;
  }

  @override
  Future<Character?> getCharacterDetails(int id) async {
    var client = http.Client();

    var url = Uri.parse('https://rickandmortyapi.com/api/character/$id');
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = response.body;
      return characterFromJson(json);
    } else {
      debugPrint('error - ${response.statusCode}');
    }
    return null;
  }
}