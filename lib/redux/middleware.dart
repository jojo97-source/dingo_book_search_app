import 'package:dingo_search_app/api/client.dart';
import 'package:dingo_search_app/redux/actions.dart';
import 'package:dingo_search_app/redux/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> getMiddlewares(ApiClient apiClient) {
  return [
    TypedMiddleware<AppState, DoSearch>(_doSearchMiddleware(apiClient))
  ];
}

Middleware<AppState> _doSearchMiddleware(ApiClient apiClient) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    if (action is DoSearch) {
      ApiClient().fetchSearchResults(action.query).then((value) {
          store.dispatch(GotSearchResults(results: value));
      }
      ).catchError((error) {
        store.dispatch(SearchFailed());
      });
    }
  };
}