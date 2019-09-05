import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/models.dart';

enum TerminalLoadState { Loading, Loaded }

abstract class TerminalFacade {
  void receiveContractsState(ContractsState state);

  void selectTerminal(TerminalData terminal);

  Stream<TerminalLoadState> get onTerminalLoadStateChanged;
}
