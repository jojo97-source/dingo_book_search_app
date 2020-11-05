import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:dingo_search_app/models/search_result.dart';
import 'package:dingo_search_app/redux/app_state.dart';
import 'package:dingo_search_app/redux/store.dart';
import 'package:dingo_search_app/ui/search_result_widget.dart';
import 'package:redux/redux.dart';
import 'redux/actions.dart';
import 'package:dingo_search_app/developer.dart';


void main() {
  return runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Dingo Book Search',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          'home':(context) => MyHomePage(),
          'secondPage': (context) => SecondPage(),
        },
        initialRoute: 'home',
      ),
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
  _MyHomePageState();

  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Dingo Search"),

      ),

      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 24.0, 16.0, 4.0),
            child: TextField(
            style: TextStyle(color: Colors.black),
            onChanged: (string) {
                setState(() {
                  this.currentText = string;
                });
              },
              decoration: InputDecoration(
              icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: " Type Here",
          hintStyle: TextStyle(color: Colors.black)),
            ),
          ),

          StoreConnector<AppState,_SearchScreenViewModel>(
            converter: (store) {
              return _SearchScreenViewModel(
                state: store.state.searchState
              );
            },
            builder: (context, viewModel) => RaisedButton(
              onPressed: () {
                store.dispatch(DoSearch(currentText));
              },
              child: Text(
                "SEARCH"
              ),
            ),
          ),

          StoreConnector<AppState, _SearchScreenViewModel>(
            converter: (store) {
              return _SearchScreenViewModel(
                  state: store.state.searchState,
              );
            },
            builder: (context, viewModel) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("STATUS :"),
                  Text(viewModel.state.toString())
                ],
              );
            },
          ),
          StoreConnector<AppState, _SearchScreenViewModel>(
            converter: (store) {
              return _SearchScreenViewModel(
                state: store.state.searchState,
                results: store.state.searchResults
              );
            },
            builder: (context, viewModel) {
              return Expanded(
                child: viewModel.state != SearchState.SUCCESS ? Text("EMPTY LIST")
                    : ListView.builder(
                    itemCount: viewModel.results.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SearchResultWidget(document: viewModel.results.docs[index]);

                    }
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
navigateToPage(BuildContext context, String page) {
  Navigator.of(context).pushNamedAndRemoveUntil(page, (Route<dynamic> route) => false);
}

class _SearchScreenViewModel {
  final SearchState state;
  final SearchResult results;

  _SearchScreenViewModel({this.state, this.results});
}