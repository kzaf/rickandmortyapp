import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/characters_bloc.dart';
import 'package:rickandmortyapp/model/all_characters.dart';

import '../constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CharactersBloc charactersBloc = CharactersBloc();

  @override
  void initState() {
    charactersBloc.add(GetAllCharactersList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePageTitle),
        centerTitle: true,
      ),
      body: allCharactersList()
    );
  }

  Widget allCharactersList() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => charactersBloc,
        child: BlocListener<CharactersBloc, CharactersBlocState>(
          listener: (context, state) {
            if (state is CharactersBlocError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CharactersBloc, CharactersBlocState>(
            builder: (context, state) {
              if (state is CharactersBlocInitial) {
                return buildLoading();
              } else if (state is CharactersBlocLoading) {
                return buildLoading();
              } else if (state is CharactersBlocLoaded) {
                return buildCard(context, state.allCharacters);
              } else {
                return buildLoading();
              }
            },
          ),
      ),
      )
    );
  }

  Widget buildCard(BuildContext context, AllCharacters allCharactersModel) {
    return ListView.builder(
      itemCount: allCharactersModel.info?.count,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
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
    );
  }

  Widget buildLoading() => Center(child: CircularProgressIndicator());
}

