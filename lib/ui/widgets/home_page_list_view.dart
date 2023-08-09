import 'package:flutter/material.dart';
import 'package:rickandmortyapp/model/all_characters.dart';

class HomePageListView extends StatelessWidget {
  const HomePageListView({
    super.key,
    required this.allCharacters,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final List<Results?>? allCharacters;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: allCharacters?.length,
      itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: ClipRRect(child: Image.network("${allCharacters?[index]?.image}")),
            title: Text("${allCharacters?[index]?.name}"),
            subtitle: Text("${allCharacters?[index]?.status}"),
            onTap: () {
              ScaffoldMessenger
                .of(context)
                .showSnackBar(SnackBar(content: Text('$index')));
            },
          ),
        ),
    );
  }
}