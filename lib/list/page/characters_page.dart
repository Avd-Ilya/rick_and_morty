import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/characters_bloc.dart';
import '../../model/character_model.dart';
import '../../details/page/character_details_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<Character> characters = [];
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<CharactersBloc>().add(NeedCharacters());
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters'),
      ),
      body: Center(
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            if (state is CharactersLoading) {
              return const CircularProgressIndicator();
            }
            if (state is CharactersLoaded) {
              characters.addAll(state.characters);
              return ListView.separated(
                controller: controller,
                separatorBuilder: (context, index) {
                  return const Divider(
                    endIndent: 10,
                    indent: 5,
                    thickness: 1,
                    height: 5,
                  );
                },
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        context.read<CharactersBloc>().add(
                            CharactersShouldShowDetails(
                                characterId: characters[index].id));
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return CharacterDetailsPage(
                        //         cahracterId: characters[index].id,
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(characters[index].image),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    characters[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    characters[index].species,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    characters[index].gender,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is CharactersError) {
              return const Center(
                child: Text('Data loading error!'),
              );
            }
            if (state is CharactersShowDetails) {
              Future.delayed(Duration.zero, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CharacterDetailsPage(
                          cahracterId: state.characterId);
                    },
                  ),
                ).then((_) {
                  context.read<CharactersBloc>().add(NeedCharacters());
                });
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
