import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/details_page_bloc/details_bloc.dart';

import '../../constants/dimensions.dart';
import '../../constants/strings.dart';
import '../../constants/styles.dart';

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

  _buildDetailsPage(DetailsBlocLoaded state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          pinned: true,
          centerTitle: false,
          expandedHeight: Dimensions.detailsPageImageExpandedHeight,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              state.characterDetails.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(
            Dimensions.detailsPageTitlePadding,
          ),
          sliver: SliverAppBar(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimensions.detailsPageTitleBorderRadius,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(
                Dimensions.detailsPageTitleBottomHeight,
              ),
              child: const SizedBox(),
            ),
            flexibleSpace: Center(
              child: Text(
                state.characterDetails.name,
                style: AppTextStyle.headlineDetails,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCard(
                Strings.detailsPageLabelStatus,
                state.characterDetails.status.capitalize(),
                'icons/status.png',
              ),
              _buildCard(
                Strings.detailsPageLabelGender,
                state.characterDetails.gender,
                'icons/gender.png',
              ),
              _buildCard(
                Strings.detailsPageLabelSpecies,
                state.characterDetails.species,
                'icons/species.png',
              ),
              _buildCard(
                Strings.detailsPageLabelLastKnownLocation,
                state.characterDetails.locationName,
                'icons/location.png',
              ),
              _buildCard(
                Strings.detailsPageLabelOrigin,
                state.characterDetails.originName,
                'icons/origin.png',
              ),
              _buildCard(
                Strings.detailsPageLabelNumberOfEpisodes,
                state.characterDetails.episodes.length.toString(),
                'icons/number_of_episodes.png',
              ),
              _buildExpansionTile(
                Strings.detailsPageLabelEpisodes,
                state,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildExpansionTile(title, state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        elevation: Dimensions.detailsPageExpansionTileElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.detailsPageCardRadius,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            Dimensions.detailsPageExpansionTilePadding,
          ),
          child: ExpansionTile(
            leading: Image.asset(
              'icons/episodes.png',
            ),
            shape: const Border(),
            title: Text(
              title,
              style: AppTextStyle.titleStyle,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            children: state.characterDetails.episodes.map<Widget>((item) {
              return ListTile(
                title: Expanded(
                  child: Text(
                    item,
                    style: AppTextStyle.textStyle,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  _buildCard(title, text, image) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 10,
      child: Card(
        elevation: Dimensions.detailsPageCardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.detailsPageCardRadius,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(
            Dimensions.detailsPageCardPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  leading: Image.asset(
                    image,
                  ),
                  title: Text(
                    title,
                    style: AppTextStyle.titleStyle,
                  ),
                  subtitle: Text(
                    text.toString().capitalize(),
                    style: AppTextStyle.textStyle,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
