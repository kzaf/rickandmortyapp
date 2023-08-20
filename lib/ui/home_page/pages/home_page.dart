import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/ui/home_page/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/home_page/widgets/home_page_list_item.dart';

import '../../../bloc/home_page_bloc/home_bloc.dart';
import '../../../constants/dimensions.dart';
import '../../../constants/strings.dart';
import '../../common/progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _charactersBloc = CharactersBloc();
  final _scrollController = ScrollController();
  List<HomeListItem> _existingCharactersList = [];
  String? _nextPageUrl = Strings.emptyString;
  bool _shouldLoadNext = true;
  bool _firstLoad = true;

  @override
  void initState() {
    _charactersBloc.add(
      GetAllCharactersList(_existingCharactersList, _nextPageUrl),
    );
    _handleNextPage();
    super.initState();
  }

  @override
  void dispose() {
    _charactersBloc.close();
    super.dispose();
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
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CharactersBlocInitial) {
              return Center(
                child: ProgressWithIcon(
                  size: Dimensions.progressIndicatorSizeBig,
                ),
              );
            } else if (state is CharactersBlocLoaded) {
              _nextPageUrl = state.nextPageUrl;
              _existingCharactersList = state.allCharacters;
              _shouldLoadNext = _nextPageUrl != null;
            }
            if (_firstLoad) {
              _firstLoad = false;
              return Center(
                child: ProgressWithIcon(
                  size: Dimensions.progressIndicatorSizeBig,
                ),
              );
            } else {
              return _buildAllCharactersList(_existingCharactersList);
            }
          },
        ),
      ),
    );
  }

  ListView _buildAllCharactersList(List<HomeListItem> allCharacters) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      key: const PageStorageKey(0),
      controller: _scrollController,
      itemCount: allCharacters.length + (_shouldLoadNext ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= allCharacters.length) {
          return Padding(
            padding: EdgeInsets.all(
              Dimensions.homePageListItemLoaderPadding,
            ),
            child: Center(
              child: ProgressWithIcon(
                size: Dimensions.progressIndicatorSizeSmall,
              ),
            ),
          );
        } else {
          return HomePageListItem(
            allCharacters: allCharacters,
            index: index,
          );
        }
      },
    );
  }

  void _handleNextPage() {
    _scrollController.addListener(
      () async {
        if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels) {
          if (_shouldLoadNext) {
            _charactersBloc.add(
              GetAllCharactersList(_existingCharactersList, _nextPageUrl),
            );
          }
        }
      },
    );
  }
}
