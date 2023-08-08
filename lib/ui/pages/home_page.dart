import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/characters_bloc.dart';
import 'package:rickandmortyapp/ui/widgets/home_page_list_view.dart';
import 'package:rickandmortyapp/ui/widgets/loading_indicator.dart';

import '../../constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CharactersBloc charactersBloc = CharactersBloc();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    charactersBloc.add(GetAllCharactersList());
    handleNext();
    super.initState();
  }

  void handleNext() {
    scrollController.addListener(() async {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        print('next');
      } else if (scrollController.position.minScrollExtent == scrollController.position.pixels) {
        print('previous');
      }
    });
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
    return BlocProvider(
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
            return state is CharactersBlocLoaded
                ? HomePageListView(context, state.allCharacters, charactersBloc, scrollController)
                : const LoadingIndicator();
          },
        ),
    ),
    );
  } 
}