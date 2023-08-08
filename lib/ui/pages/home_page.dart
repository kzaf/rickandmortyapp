import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/characters_bloc.dart';
import 'package:rickandmortyapp/model/all_characters.dart';
import 'package:rickandmortyapp/ui/widgets/home_page_list_view.dart';
import 'package:rickandmortyapp/ui/widgets/loading_indicator.dart';

import '../../constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final CharactersBloc charactersBloc = CharactersBloc();
  final ScrollController scrollController = ScrollController();
  List<Results>? existingCharactersList = [];
  String? nextPageUrl;

  @override
  void initState() {
    charactersBloc.add(GetAllCharactersList());
    handleNextPage();
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

  void handleNextPage() {
    scrollController.addListener(() async {
      if(scrollController.position.maxScrollExtent == scrollController.position.pixels) {
        charactersBloc.add(GetAllCharactersListNext(nextPageUrl));
      } else if (scrollController.position.minScrollExtent == scrollController.position.pixels) {
        // charactersBloc.add(GetAllCharactersListPrevious());
      }
    });
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
            if (state is CharactersBlocInitial) {
              return const LoadingIndicator();
            } else if (state is CharactersBlocLoading) {
              return const LoadingIndicator();
            } else if (state is CharactersBlocLoaded) {
              nextPageUrl = state.allCharacters.info?.next;
              existingCharactersList = state.allCharacters.results;
              return HomePageListView(allCharacters: state.allCharacters.results, scrollController: scrollController);
            } else if (state is CharactersBlocLoadingNext) {
              return const LoadingIndicator(); // bottom loader
            } else if (state is CharactersBlocLoadedNext) {
              nextPageUrl = state.allCharacters.info?.next;
              existingCharactersList?.addAll(state.allCharacters.results as Iterable<Results>);
              return HomePageListView(allCharacters: existingCharactersList, scrollController: scrollController);
            } else {
              return const LoadingIndicator();
            }
          },
        ),
    ),
    );
  } 
}