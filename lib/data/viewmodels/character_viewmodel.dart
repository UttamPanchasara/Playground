import 'package:flutter/material.dart';
import 'package:playground/base/base_viewmodel.dart';
import 'package:playground/base/view_state.dart';
import 'package:playground/data/repo/api_data_repository.dart';

class CharacterViewModel extends ChangeNotifier with BaseViewModel {
  var apiRepository = ApiDataRepository();
  ViewState _viewState = ViewState.loading();

  ViewState get state => _viewState;

  updateViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  void getCharacters({int? pageNo}) {
    subscription.add(handleAPICall(apiRepository.getCharacters(pageNo ?? 0))
        .listen((viewState) {
      updateViewState(viewState);
    }));
  }
}
