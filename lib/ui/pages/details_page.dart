import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/details_page_bloc/details_bloc.dart';

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
        child: BlocConsumer<DetailsBloc, DetailsBlocState> (
          listener: (context, state) {
            if (state is DetailsBlocError) {
              Center(child: Text(state.message));
            }
          },
          builder: (context, state) {
            if (state is DetailsBlocInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailsBlocLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DetailsBlocLoaded) {
              return _buildDetailsPage(state);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
      )
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
              fit: BoxFit.cover
            ),
          ),
        ),
        SliverAppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          pinned: true,
          bottom: const PreferredSize(preferredSize: Size.fromHeight(-10.0), child: SizedBox()),
          flexibleSpace: Center(child: Text(state.characterDetails.name, style: AppTextStyle.headlineDetails))
        ),
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Status', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.status.capitalize(), style: AppTextStyle.titleDetails),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Gender', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.gender, style: AppTextStyle.titleDetails),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Species', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.species, style: AppTextStyle.titleDetails),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Last known location', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.locationName, style: AppTextStyle.titleDetails),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Origin', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.originName, style: AppTextStyle.titleDetails),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text('Number of episodes', style: AppTextStyle.captionDetails),
                      Text('${state.characterDetails.episodes.length}', style: AppTextStyle.titleDetails),
                    ],
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: Text('Episodes'),
                        children: state.characterDetails.episodes.map((item) {
                          return ListTile(
                            title: Text(item),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
              
              
            ],
          ),
        )
      ],



      
    );
  }
}
