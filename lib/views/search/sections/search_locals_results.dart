import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/widgets/local_cell.dart';

class LocalResults extends StatefulWidget {
  @override
  createState() => _LocalResultsState();
}

class _LocalResultsState extends State<LocalResults> {
  ScrollController _scrollController = ScrollController();

  int index;
  SearchType type;

  @override
  void initState() {
    super.initState();
    index = 0;

    SearchViewModel searchViewModel =
        Provider.of<SearchViewModel>(context, listen: false);

    setState(() {
      type = searchViewModel.type;
    });

    searchViewModel.fetchLocalsSearch(index);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          searchViewModel.localSearchRequest.hasMorePages()) {
        index++;
        searchViewModel.fetchLocalsSearch(index);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) => Container(
        height: MediaQuery.of(context).size.height - 184,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: searchViewModel.locals.length,
          itemBuilder: (BuildContext context, int index) {
            var placeholder = 'assets/images/profile.png';
            var local = searchViewModel.locals[index];
            var url = local.photos.first != ""
                ? '${Api.endpoint}/${local.photos.first}'
                : placeholder;
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: LocalCell(
                imageUrl: url,
                localId: local.id,
                name: local.name,
                price: local.price,
                description: local.description,
              ),
            );
          },
        ),
      ),
    );
  }
}
