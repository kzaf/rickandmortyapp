import 'package:flutter/material.dart';
import 'package:rickandmortyapp/api/model/all_characters.dart';
import 'package:rickandmortyapp/ui/ui_model/home_list_item.dart';
import 'package:rickandmortyapp/ui/pages/details_page.dart';
import 'package:rickandmortyapp/ui/widgets/loading_indicator.dart';

class HomePageListView extends StatelessWidget {
  final ScrollController scrollController;
  final List<HomeListItem?>? allCharacters;
  final bool showLoader;

  const HomePageListView({
    super.key,
    required this.allCharacters,
    required this.scrollController,
    required this.showLoader
  });

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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${allCharacters?[index]?.status} - ${allCharacters?[index]?.species}"),
            Text("Last seen: ${allCharacters?[index]?.lastLocation}"),
            Text("First seen: ${allCharacters?[index]?.firstLocation}")
          ],
        ),
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (BuildContext context) => DetailsPage(index: index)
            )
          );
        },
      ),
    );
  }
}