import 'package:playground/data/repo/api_manager.dart';
import 'package:rxdart/rxdart.dart';

import 'view_state.dart';

class BaseViewModel {
  final ApiManager _apiManager = ApiManager();
  CompositeSubscription subscription = CompositeSubscription();

  Stream<ViewState<T>> handleAPICall<T>(Stream source, {customResponse}) {
    return _apiManager.callApi<T>(source, customResponse: customResponse);
  }

  void dispose() {
    subscription.clear();
  }
}
