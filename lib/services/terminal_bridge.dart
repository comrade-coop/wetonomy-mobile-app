import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state.dart';
import 'package:wetonomy/bloc/terminal_interaction/terminal_interaction_state_after_query.dart';
import 'package:wetonomy/models/contract.dart';
import 'package:wetonomy/models/terminal_data.dart';

abstract class TerminalBridge {
  void selectTerminal(TerminalData terminal);

  void handleContractsStateChange(Contract state);

  void handleQueryResponse(TerminalInteractionStateAfterQuery state);

  void handleActionResponse(TerminalInteractionStateAfterAction state);
}
