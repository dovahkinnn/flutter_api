import 'package:flutter/material.dart';
import 'package:flutterweb/search.dart';

import 'bloc/user_bloc.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  UserBLoC userBLoC = new UserBLoC();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              }),
        ],
      ),
      body: StreamBuilder(
          stream: userBLoC.usersList(),
          // ignore: missing_return
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: Text("yok"));
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                if (snapshot.hasError)
                  return Text('There was an error : ${snapshot.error}');
                var users = snapshot.data;

                return ListView.separated(
                  itemCount: users?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    User _user = users[index];
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_user.price),
                        ],
                      ),
                      subtitle: Text(_user.symbol),
                      leading: CircleAvatar(
                        child: Text(_user.symbol[0]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                );
              case ConnectionState.done:
                break;
            }
          }),
    );
  }
}
