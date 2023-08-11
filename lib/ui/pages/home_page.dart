import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/ui/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/widgets/home_page_list_item.dart';
import 'package:rickandmortyapp/ui/widgets/loading_indicator.dart';

import '../../bloc/home_page_bloc/home_bloc.dart';
import '../../constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final CharactersBloc _charactersBloc = CharactersBloc();
  final ScrollController _scrollController = ScrollController();
  final List<HomeListItem> _existingCharactersList = [];
  String? _nextPageUrl = Strings.emptyString;
  bool _shouldLoadNext = true;

  @override
  void initState() {
    _charactersBloc.add(GetAllCharactersList(_existingCharactersList, _nextPageUrl));
    _handleNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePageTitle),
        centerTitle: true,
      ),
      body: _allCharactersList()
    );
  }

  void _handleNextPage() {
    _scrollController.addListener(() async {
      if(_scrollController.position.maxScrollExtent == _scrollController.position.pixels) {
        if(_shouldLoadNext){
          _charactersBloc.add(GetAllCharactersList(_existingCharactersList, _nextPageUrl));
        }
      }
    });
  }

  Widget _allCharactersList() {
    return BlocProvider(
      create: (context) => _charactersBloc,
      child: BlocConsumer<CharactersBloc, CharactersBlocState>(
        listener: (context, state) {
          if (state is CharactersBlocError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CharactersBlocInitial) {
            return const LoadingIndicator();
          } else if (state is CharactersBlocLoading) {
            _shouldLoadNext = false;
            return HomePageListView(
                allCharacters: _existingCharactersList,
                scrollController: _scrollController,
                showLoader: true,
                nextPageUrl: _nextPageUrl);
          } else if (state is CharactersBlocLoaded) {
            _shouldLoadNext = true;
            _nextPageUrl = state.nextPageUrl;
            return HomePageListView(
                allCharacters: state.allCharacters,
                scrollController: _scrollController, 
                showLoader: false,
                nextPageUrl: _nextPageUrl,);
          } else {
            return const LoadingIndicator();
          }
        },
      ),
    );
  } 
}