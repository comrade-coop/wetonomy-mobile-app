import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/models.dart';
import 'package:wetonomy/repositories/repositories.dart';
import 'package:wetonomy/services/terminal_facade.dart';
import 'package:wetonomy/services/mock_contracts_api_client.dart';

import 'mocks/mock_terminal_manager.dart';

class MockFlutterWebviewPlugin extends Mock implements FlutterWebviewPlugin {}

class MockContractsBloc extends Mock implements ContractsBloc {}

class MockTerminalFacade extends Mock implements TerminalFacade {}

void main() {
  group('TerminalsManagerBloc', () {
    TerminalsManagerBloc terminalsBloc;

    setUp(() {
      final repository =
          TerminalsRepository(MockTerminalManager(), MockTerminalFacade());
      terminalsBloc = TerminalsManagerBloc(repository,
          ContractsBloc(ContractsRepository(MockContractsApiClient())));
    });

    test('Initial state is correct', () {
      expect(terminalsBloc.initialState, InitialTerminalsManagerState());
    });

    test('Loading of terminals is correct', () {
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        LoadingTerminalsManagerState(),
        EmptyTerminalsManagerState()
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));

      terminalsBloc.dispatch(LoadTerminalsEvent());
    });

    test('Adding of a terminal is correct', () {
      final terminal1 = TerminalData('https://example.com', '');
      final terminal2 = TerminalData('https://example1.com', '');
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        AddedTerminalState([terminal1], terminal1),
        AddedTerminalState([terminal1, terminal2], terminal2),
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));
      terminalsBloc.dispatch(AddTerminalEvent(terminal1));
      terminalsBloc.dispatch(AddTerminalEvent(terminal2));
    });

    test('Selecting of a terminal is correct', () {
      final terminal1 = TerminalData('https://example.com', '');
      final terminal2 = TerminalData('https://example1.com', '');
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        AddedTerminalState([terminal1], terminal1),
        AddedTerminalState([terminal1, terminal2], terminal2),
        SelectedTerminalState([terminal1, terminal2], terminal1),
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));
      terminalsBloc.dispatch(AddTerminalEvent(terminal1));
      terminalsBloc.dispatch(AddTerminalEvent(terminal2));
      terminalsBloc.dispatch(SelectTerminalEvent(terminal1));
    });

    test('Removing of a terminal is correct', () {
      final terminal1 = TerminalData('https://example.com', '');
      final terminal2 = TerminalData('https://example1.com', '');
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        AddedTerminalState([terminal1], terminal1),
        AddedTerminalState([terminal1, terminal2], terminal2),
        RemovedTerminalState([terminal2], terminal2),
        EmptyTerminalsManagerState()
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));
      terminalsBloc.dispatch(AddTerminalEvent(terminal1));
      terminalsBloc.dispatch(AddTerminalEvent(terminal2));
      terminalsBloc.dispatch(RemoveTerminalEvent(terminal1));
      terminalsBloc.dispatch(RemoveTerminalEvent(terminal2));
    });
  });
}
