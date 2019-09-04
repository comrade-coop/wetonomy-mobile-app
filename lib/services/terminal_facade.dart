import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/models.dart';

abstract class TerminalFacade {
  void receiveContractsState(ContractsState state);

  void loadTerminal(TerminalData terminal);
}
