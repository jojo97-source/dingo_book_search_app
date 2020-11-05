import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dingo_search_app/utils/constants.dart';
import 'package:dingo_search_app/models/search_result.dart';

class ApiClient {
  final String baseUrl;

  ApiClient({
    this.baseUrl = Constants.BASE_URL
  });

  Future<SearchResult> fetchSearchResults(String term) async {
    final uri = Uri.parse("${baseUrl}search.json?q=$term");
    final response = await http.get(uri);

    return SearchResult.fromJson(json.decode(response.body));
  }

}