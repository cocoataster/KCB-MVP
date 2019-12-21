import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/widgets/member_cell.dart';

class MemberResults extends StatefulWidget {
  @override
  createState() => _MemberResultsState();
}

class _MemberResultsState extends State<MemberResults> {
  List<Profile> profiles = List();
  ScrollController _scrollController = ScrollController();

  int index;
  SearchType type;

  @override
  void initState() {
    super.initState();
    index = 0;

    setState(() {
      profiles = Provider.of<SearchViewModel>(context, listen: false).profiles;
      type = Provider.of<SearchViewModel>(context, listen: false).type;
    });

    Provider.of<SearchViewModel>(context, listen: false)
        .fetchMembersSearch(index);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        index++;
        Provider.of<SearchViewModel>(context, listen: false)
            .fetchMembersSearch(index);
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
          itemCount: searchViewModel.profiles.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              child: MemberCell(
                imageUrl: searchViewModel.profiles[index].photo != ''
                    ? '${Api.endpoint}/${searchViewModel.profiles[index].photo}'
                    : 'https://cdn3.iconfinder.com/data/icons/black-easy/512/538642-user_512x512.png',
                name: searchViewModel.profiles[index].name,
                friendlyLocation:
                    searchViewModel.profiles[index].friendlyLocation,
                instruments: searchViewModel.profiles[index].instruments,
                followers: searchViewModel.profiles[index].followers,
                id: searchViewModel.profiles[index].id,
              ),
            );
          },
        ),
      ),
    );
  }
}
