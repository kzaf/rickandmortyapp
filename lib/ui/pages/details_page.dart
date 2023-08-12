import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/details_page_bloc/details_bloc.dart';
import 'package:rickandmortyapp/constants/dimensions.dart';

import '../../constants/strings.dart';
import '../../constants/styles.dart';
import '../widgets/loading_indicator.dart';

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
      appBar: AppBar(
        title: Text(widget.name ?? ''),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => _detailsBloc,
        child: BlocBuilder<DetailsBloc, DetailsBlocState>(
          builder: (context, state) {
            if (state is DetailsBlocInitial) {
              return const LoadingIndicator();
            } else if (state is DetailsBlocLoading) {
              return const LoadingIndicator();
            } else if (state is DetailsBlocLoaded) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(state.characterDetails.name, style: AppTextStyle.headlineDetails),
                      Container(
                        margin: EdgeInsets.all(Dimensions.detailsPageTitleMargin),
                        child: Image.network(state.characterDetails.image),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.detailsPageStatusDecorationBorderRadius),
                              color: state.characterDetails.status == Strings.aliveStatus
                                  ? Colors.green
                                  : state.characterDetails.status == Strings.deadStatus
                                      ? Colors.red
                                      : Colors.grey,
                            ),
                          ),
                          SizedBox(width: Dimensions.detailsPageStatusSizedBoxWidth),
                          Text(state.characterDetails.status.capitalize(), style: AppTextStyle.titleDetails),
                        ],
                      ),
                      SizedBox(height:20),
                      Text('Gender', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.gender, style: AppTextStyle.titleDetails),
                      SizedBox(height:10),

                      Text('Species', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.species, style: AppTextStyle.titleDetails),
                      SizedBox(height:10),

                      Text('Last known location', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.locationName, style: AppTextStyle.titleDetails),
                      SizedBox(height:10),

                      Text('Origin', style: AppTextStyle.captionDetails),
                      Text(state.characterDetails.originName, style: AppTextStyle.titleDetails),
                      SizedBox(height:10),

                      Text('Number of episodes', style: AppTextStyle.captionDetails),
                      Text('${state.characterDetails.episodes.length}', style: AppTextStyle.titleDetails),
                      SizedBox(height:10),
                      
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
              );
            }else {
              return const LoadingIndicator();
            }
          },
        ),
      )
    );
  }
}
