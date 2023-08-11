import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmortyapp/bloc/details_page_bloc/details_bloc.dart';

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
              return Card(
                child: ListTile(
                  leading: ClipRRect(child: Image.network("${state.characterDetails.image}")),
                  title: Text("${state.characterDetails.name}"),
                  subtitle: Text("${state.characterDetails.status}"),
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
