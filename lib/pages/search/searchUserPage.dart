import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/user_search_card.dart';
import 'package:mobile/services/chat_service.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({Key? key}) : super(key: key);

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  String searchValue = '';
  List<Widget> result = [];

  Future<void> getUsers(String search) async {
    var list = await ChatService.searchUser(search);
    setState(() {
      result.addAll(list.map((e) => UserSearchCard(userSearchModel: e)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EasySearchBar(
          title: const Text('Tìm kiếm'),
          onSearch: (value) {
            setState(() {
              result = [];
            });
            EasyDebounce.debounce('my-debouncer', Duration(seconds: 1), () {
              if (value != "") {
                print("searching for" + value);
                getUsers(value);
              } else {
                setState(() {
                  result = [];
                });
              }
            });
          },
          //suggestions: _suggestions,
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: result,
            ),
          ),
        ));
  }
}
