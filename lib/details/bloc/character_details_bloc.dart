import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/service/character_service_impl.dart';
import '../../model/character_model.dart';
import '../../service/character_service.dart';
part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final CharacterService characterService;

  CharacterDetailsBloc(this.characterService) : super(CharacterDetailsInitial()) {
    on<NeedCharacter>((event, emit) async {
      emit(CharacterDetailsLoading());
      final response =
          await characterService.getCharacterDetails(event.characterId);

      response.fold(
        (exception) {
          emit(CharacterDetailsError(message: exception.message));
        },
        (value) {
          if (value != null) {
            emit(CharacterDetailsLoaded(character: value));
          }
        },
      );
    });
  }
}
