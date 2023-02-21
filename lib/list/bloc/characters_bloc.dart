import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/service/character_service_impl.dart';
import '../../model/character_model.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  CharactersBloc() : super(CharactersInitial()) {
    var page = 1;

    on<NeedCharacters>((event, emit) async {
      if (state is CharactersInitial) {
        emit(CharactersLoading());
      }

      final response = await CharacterServiceImpl().getCharacters(page);
      response.fold(
        (exception) {
          emit(CharactersError(message: exception.message));
        },
        (value) {
          if (value != null) {
            page += 1;
            emit(CharactersLoaded(characters: value));
          }
        },
      );
    });
  }
}
