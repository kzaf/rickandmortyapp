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

  CustomScrollView _buildDetailsPage(DetailsBlocLoaded state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          pinned: true,
          centerTitle: false,
          expandedHeight: 300.0,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              state.characterDetails.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(10.0),
          sliver: SliverAppBar(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            automaticallyImplyLeading: false,
            pinned: true,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: SizedBox(),
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
                'Status',
                state.characterDetails.status.capitalize(),
              ),
              _buildCard(
                'Gender',
                state.characterDetails.gender,
              ),
              _buildCard(
                'Species',
                state.characterDetails.species,
              ),
              _buildCard(
                'Last known location',
                state.characterDetails.locationName,
              ),
              _buildCard(
                'Origin',
                state.characterDetails.originName,
              ),
              _buildCard(
                'Number of episodes',
                state.characterDetails.episodes.length.toString(),
              ),
              _buildExpansionTile(
                'Episodes',
                state,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildExpansionTile(title, state) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.detailsPageCardRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ExpansionTile(
            shape: const Border(),
            title: Text(title),
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

  _buildCard(title, text) {
    return Container(
      width: MediaQuery.of(context).size.width - 10,
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            Dimensions.detailsPageCardRadius,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title + ':',
                  style: AppTextStyle.titleStyle,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: AppTextStyle.textStyle,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
