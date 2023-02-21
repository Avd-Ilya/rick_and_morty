import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/character_details_bloc.dart';

class CharacterDetailsWidget extends StatelessWidget {
  const CharacterDetailsWidget({super.key, required this.cahracterId});

  final int cahracterId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: Center(
        child: BlocBuilder<CharacterDetailsBloc, CharacterDetailsState>(
          builder: (BuildContext context, state) {
            if (state is CharacterDetailsInitial) {
              context
                  .read<CharacterDetailsBloc>()
                  .add(NeedCharacter(characterId: cahracterId));
            }
            if (state is CharacterDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CharacterDetailsLoaded) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Image.network(state.character.image),
                    ),
                    ...buildText(state.character.name),
                    ...buildText(state.character.species),
                    ...buildText(state.character.gender),
                    ...buildText(state.character.status),
                    ...buildText(state.character.location.name),
                    ...buildText(
                      'Number of episode - ${state.character.episode.length}',
                    ),
                  ],
                ),
              );
            }
            if (state is CharacterDetailsError) {
              return const Center(
                child: Text('Data loading error!'),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  List<Widget> buildText(String text) {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    ];
  }
}
