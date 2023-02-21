import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/details/bloc/character_details_bloc.dart';
import '../widgets/character_details_widget.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key, required this.cahracterId});

  final int cahracterId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterDetailsBloc(),
      child: CharacterDetailsWidget(cahracterId: cahracterId),
    );
  }
}