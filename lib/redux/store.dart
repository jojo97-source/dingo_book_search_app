import 'package:dingo_search_app/api/client.dart';
import 'package:dingo_search_app/redux/middleware.dart';
import 'package:dingo_search_app/redux/reducer.dart';
import 'package:redux/redux.dart';
import 'app_state.dart';

final store = Store<AppState>(
    reducer,
    initialState: AppState.create(),
    middleware: getMiddlewares(ApiClient())
);