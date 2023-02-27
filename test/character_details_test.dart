import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty/details/bloc/character_details_bloc.dart';
import 'package:rick_and_morty/model/character_model.dart';
import 'mock_character_service.dart';

void main() {
  group('Character details', () {
    late CharacterDetailsBloc characterDetailsBloc;
    late MockCharacterService mockCharacterService;

    setUp(() {
      mockCharacterService = MockCharacterService();
      characterDetailsBloc = CharacterDetailsBloc(mockCharacterService);
    });

    blocTest<CharacterDetailsBloc, CharacterDetailsState>(
      'emits [CharacterDetailsLoading, CharacterDetailsLoaded] when NeedCharacter is added.',
      setUp: () {
        mockCharacterService.getCharacterDetailsSuccess();
      },
      build: () => CharacterDetailsBloc(mockCharacterService),
      act: (bloc) => bloc.add(const NeedCharacter(characterId: 1)),
      expect: () => <CharacterDetailsState>[
        CharacterDetailsLoading(),
        CharacterDetailsLoaded(character: Character.empty())
      ],
    );

    blocTest<CharacterDetailsBloc, CharacterDetailsState>(
      'emits [CharacterDetailsLoading, CharacterDetailsError] when NeedCharacter is added.',
      setUp: () {
        mockCharacterService.getCharacterDetailsFailure();
      },
      build: () => CharacterDetailsBloc(mockCharacterService),
      act: (bloc) => bloc.add(const NeedCharacter(characterId: 1)),
      expect: () => <CharacterDetailsState>[
        CharacterDetailsLoading(),
        const CharacterDetailsError(message: '')
      ],
    );

    tearDown(() {
      characterDetailsBloc.close();
    });
  });
}