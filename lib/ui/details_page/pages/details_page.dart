import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/details_page_bloc/details_bloc.dart';
import 'package:rickandmortyapp/ui/details_page/widgets/details_page_card.dart';

import '../../../constants/strings.dart';
import '../../../constants/styles.dart';
import '../widgets/details_page_expansion_tile.dart';
import '../widgets/details_page_image.dart';
import '../widgets/details_page_name.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  final String? name;

  const DetailsPage({required this.index, required this.name, super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsBloc _detailsBloc = DetailsBloc();

  @override
  void initState() {
    var indx = widget.index;
    _detailsBloc.add(GetCharacterDetails(++indx));
    super.initState();
  }

  @override
  void dispose() {
    _detailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _detailsBloc,
        child: BlocConsumer<DetailsBloc, DetailsBlocState>(
          listener: (context, state) {
            if (state is DetailsBlocError) {
              Center(
                child: Expanded(
                  child: Text(
                    state.message,
                    style: AppTextStyle.textStyle,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is DetailsBlocInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailsBlocLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailsBlocLoaded) {
              return _buildDetailsPage(state);
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

  CustomScrollView _buildDetailsPage(DetailsBlocLoaded state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        DetailsPageImage(context: context, image: state.characterDetails.image),
        DetailsPageName(name: state.characterDetails.name),
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DetailsPageCard(
                title: Strings.detailsPageLabelStatus,
                text: state.characterDetails.status.capitalize(),
                image: 'icons/status.png',
              ),
              DetailsPageCard(
                title: Strings.detailsPageLabelGender,
                text: state.characterDetails.gender,
                image: 'icons/gender.png',
              ),
              DetailsPageCard(
                title: Strings.detailsPageLabelSpecies,
                text: state.characterDetails.species,
                image: 'icons/species.png',
              ),
              DetailsPageCard(
                title: Strings.detailsPageLabelLastKnownLocation,
                text: state.characterDetails.locationName,
                image: 'icons/location.png',
              ),
              DetailsPageCard(
                title: Strings.detailsPageLabelOrigin,
                text: state.characterDetails.originName,
                image: 'icons/origin.png',
              ),
              DetailsPageCard(
                title: Strings.detailsPageLabelNumberOfEpisodes,
                text: state.characterDetails.episodes.length.toString(),
                image: 'icons/number_of_episodes.png',
              ),
              DetailsPageExpansionTile(
                context: context,
                episodesList: state.characterDetails.episodes,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
