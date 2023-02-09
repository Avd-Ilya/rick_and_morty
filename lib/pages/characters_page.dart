import 'package:flutter/material.dart';
import '../model/character_model.dart';
import '../service/character_service_impl.dart';
import 'character_details_page.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<Character> characters = [];
  var isLoaded = false;
  final controller = ScrollController();
  var page = 1;

  @override
  void initState() {
    super.initState();
    if (characters.isEmpty) {
      getData(page);
      page += 1;
    }

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        getData(page);
        page += 1;
      }
    });
  }

  getData(int page) async {
    var newCharacters = await CharacterServiceImpl().getCharacters(page);
    if (newCharacters != null) {
      // characters += newCharacters;
      characters.addAll(newCharacters);
    }
    if (characters.isNotEmpty) {
      setState(() {
        isLoaded = true;
      });
    }
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
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
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
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return CharacterDetailsPage(
                            cahracterId: characters[index].id);
                      },
                    ),
                  );
                },
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
            );
          },
        ),
      ),
    );
  }
}