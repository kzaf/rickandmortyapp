import 'package:flutter/material.dart';
import 'package:rickandmortyapp/model/all_characters.dart';

import '../../bloc/characters_bloc.dart';
import '../../constants/dimensions.dart';

class HomePageListView extends StatelessWidget {
  final AllCharacters allCharactersModel;
  final CharactersBloc charactersBloc;
  final ScrollController scrollController;

  const HomePageListView(
    BuildContext context,
    this.allCharactersModel,
    this.charactersBloc,
    this.scrollController,
    {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return buildCard(context, allCharactersModel);
  }

  Widget buildCard(BuildContext context, AllCharacters allCharactersModel) {
    return RefreshIndicator(
      onRefresh: () async { charactersBloc.add(GetAllCharactersList()); },
      child: ListView.builder(
        controller: scrollController,
        itemCount: allCharactersModel.results?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(Dimensions.homePageContainerMargin),
            child: Card(
              child: Container(
                margin: EdgeInsets.all(Dimensions.homePageCardMargin),
                child: Column(
                  children: <Widget>[
                    Text("Name: ${allCharactersModel.results?[index].name}"),
                    Text("Status: ${allCharactersModel.results?[index].status}"),
                    Text("Spieces: ${allCharactersModel.results?[index].species}"),
                    Text("Type: ${allCharactersModel.results?[index].type}"),
                    Text("Gender: ${allCharactersModel.results?[index].gender}"),
                    Text("Origin: ${allCharactersModel.results?[index].origin}"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}