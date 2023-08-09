import 'package:flutter/material.dart';
import 'package:rickandmortyapp/model/all_characters.dart';
import 'package:rickandmortyapp/ui/widgets/loading_indicator.dart';

class HomePageListView extends StatelessWidget {
  const HomePageListView({
    super.key,
    required this.allCharacters,
    required this.scrollController,
    required this.showLoader
  });

  final ScrollController scrollController;
  final List<Results?>? allCharacters;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const PageStorageKey(0),
      controller: scrollController,
      itemCount: allCharacters!.length + (showLoader ? 1 : 0),
      itemBuilder: (context, index) {
        return index >= allCharacters!.length 
        ? const LoadingIndicator() 
        : _buildDataListItem(context, index);
      },
    );
  }

  Widget _buildDataListItem(context, index) {
    return Card(
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
    );
  }
}