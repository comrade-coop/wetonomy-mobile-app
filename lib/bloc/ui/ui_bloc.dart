import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/ui/ui_event.dart';
import 'package:wetonomy/bloc/ui/ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  @override
  UiState get initialState => UiState(leftDrawerOpened: false);

  @override
  Stream<UiState> mapEventToState(
    UiEvent event,
  ) async* {
    if (event is OpenLeftDrawerUiEvent) {
      yield UiState(leftDrawerOpened: true);
    } else if (event is CloseLeftDrawerUiEvent) {
      yield UiState(leftDrawerOpened: false);
    }
  }
}
