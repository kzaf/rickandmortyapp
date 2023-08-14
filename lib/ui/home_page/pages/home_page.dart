import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/ui/home_page/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/home_page/widgets/home_page_list_item.dart';

import '../../../bloc/home_page_bloc/home_bloc.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _charactersBloc = CharactersBloc();
  final _scrollController = ScrollController();
  final List<HomeListItem> _existingCharactersList = [];
  var _nextPageUrl = Strings.emptyString;
  var _shouldLoadNext = true;

  @override
  void initState() {
    _charactersBloc.add(
      GetAllCharactersList(
        _existingCharactersList,
        _nextPageUrl,
      ),
    );
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
      body: BlocProvider(
        create: (context) => _charactersBloc,
        child: BlocConsumer<CharactersBloc, CharactersBlocState>(
          listener: (context, state) {
            if (state is CharactersBlocError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CharactersBlocInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CharactersBlocLoading) {
              _shouldLoadNext = false;
              return _buildAllCharactersList(
                _existingCharactersList,
                true,
              );
            } else if (state is CharactersBlocLoaded) {
              _shouldLoadNext = true;
              _nextPageUrl = state.nextPageUrl ?? Strings.emptyString;
              return _buildAllCharactersList(
                state.allCharacters,
                false,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  _handleNextPage() {
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (_shouldLoadNext) {
          _charactersBloc.add(
            GetAllCharactersList(
              _existingCharactersList,
              _nextPageUrl,
            ),
          );
        }
      }
    });
  }

  _buildAllCharactersList(allCharacters, showLoader) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      key: const PageStorageKey(0),
      controller: _scrollController,
      itemCount: allCharacters.length + 1,
      itemBuilder: (context, index) {
        if (_nextPageUrl != null) {
          if (index >= allCharacters.length) {
            return Padding(
              padding: EdgeInsets.all(
                Dimensions.homePageListItemLoaderPadding,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return HomePageListItem(
              allCharacters: allCharacters,
              index: index,
            );
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}