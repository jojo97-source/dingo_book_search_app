import 'package:dingo_search_app/models/search_result.dart';

class DoSearch {
  final String query;

  DoSearch(this.query);
}

class GotSearchResults {
  final SearchResult results;

  GotSearchResults({this.results});
}

class SearchFailed {}