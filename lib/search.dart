import 'package:flutter/material.dart';
import 'package:flutterweb/bloc/user_bloc.dart';

import 'models/user.dart';

class DataSearch extends SearchDelegate<List<User>> {
  UserBLoC userBLoC = new UserBLoC();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  // ignore: missing_return
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
        stream: userBLoC.usersList(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> users = snapshot.data;
            final result =
                users.where((a) => a.symbol.toLowerCase().contains(query));

            return ListView(
                children: result
                    .map((a) => ListTile(
                          title: Row(
                            children: [
                              Text(a.price),
                              
                            ],
                          ),
                          subtitle: Text(a.symbol),
                          leading: CircleAvatar(
                            child: Text(a.symbol[0]),
                          ),
                          
                        ))
                    .toList());
          }
          return Text("dsdf");
        });
  }
}
