import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/list/bloc/characters_bloc.dart';
import 'package:rick_and_morty/model/character_model.dart';
import 'mock_character_service.dart';

void main() {
  group('Characters', () {
    late CharactersBloc charactersBloc;
    late MockCharacterService mockCharacterService;

    setUp(() {
      mockCharacterService = MockCharacterService();
      charactersBloc = CharactersBloc(mockCharacterService);
    });

    blocTest<CharactersBloc, CharactersState>(
      'emits [CharactersLoading, CharactersLoaded] when NeedCharacters is added.',
      setUp: () {
        mockCharacterService.getCharactersSuccess();
      },
      build: () => CharactersBloc(mockCharacterService),
      act: (bloc) => bloc.add(NeedCharacters()),
      expect: () => <CharactersState>[
        CharactersLoading(),
        CharactersLoaded(characters: [Character.empty()])
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'emits [CharactersLoading, CharactersError] when NeedCharacters is added.',
      setUp: () {
        mockCharacterService.getCharactersFailure();
      },
      build: () => CharactersBloc(mockCharacterService),
      act: (bloc) => bloc.add(NeedCharacters()),
      expect: () => <CharactersState>[
        CharactersLoading(),
        const CharactersError(message: '')
      ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'emits [CharactersShowDetails] when CharactersShouldShowDetails is added.',
      build: () => CharactersBloc(mockCharacterService),
      act: (bloc) => bloc.add(const CharactersShouldShowDetails(characterId: 1)),
      expect: () => <CharactersState>[
        const CharactersShowDetails(characterId: 1)
      ],
    );

    tearDown(() {
      charactersBloc.close();
    });
  });
}
