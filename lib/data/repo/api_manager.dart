import 'package:playground/base/view_state.dart';
import 'package:playground/network/app_exception.dart';
import 'package:rxdart/rxdart.dart';

class ApiManager {
  Stream<ViewState<T>> callApi<T>(Stream source, {customResponse}) {
    return source.map((response) {
      return ViewState<T>.completed(customResponse ?? response);
    }).onErrorReturnWith((error, stack) {
      return ViewState<T>.error(error.toString(),
          error is NoInternetException ? Type.connection : Type.other);
    }).startWith(ViewState<T>.loading());
  }
}
