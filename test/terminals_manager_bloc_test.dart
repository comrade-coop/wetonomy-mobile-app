import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';
import 'package:wetonomy/bloc/bloc.dart';
import 'package:wetonomy/models/models.dart';
import 'package:wetonomy/repositories/repositories.dart';

import '../lib/services/fake_contracts_api_client.dart';
import 'mocks/mock_terminal_manager.dart';

class MockFlutterWebviewPlugin extends Mock implements FlutterWebviewPlugin {}

void main() {
  group('TerminalsManagerBloc', () {
    TerminalsManagerBloc terminalsBloc;

    setUp(() {
      final repository =
          TerminalsRepository(MockTerminalManager(), FakeContractsApiClient());
      terminalsBloc = TerminalsManagerBloc(repository);
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

      terminalsBloc.dispatch(LoadTerminalsManagerEvent());
    });

    test('Adding of a terminal is correct', () {
      final terminal1 = TerminalData('https://example.com', '');
      final terminal2 = TerminalData('https://example1.com', '');
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        AddedTerminalsManagerState([terminal1], terminal1),
        AddedTerminalsManagerState([terminal1, terminal2], terminal2),
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));
      terminalsBloc.dispatch(AddTerminalsManagerEvent(terminal1));
      terminalsBloc.dispatch(AddTerminalsManagerEvent(terminal2));
    });

    test('Selecting of a terminal is correct', () {
      final terminal1 = TerminalData('https://example.com', '');
      final terminal2 = TerminalData('https://example1.com', '');
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        AddedTerminalsManagerState([terminal1], terminal1),
        AddedTerminalsManagerState([terminal1, terminal2], terminal2),
        SelectedTerminalsManagerState([terminal1, terminal2], terminal1),
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));
      terminalsBloc.dispatch(AddTerminalsManagerEvent(terminal1));
      terminalsBloc.dispatch(AddTerminalsManagerEvent(terminal2));
      terminalsBloc.dispatch(SelectTerminalsManagerEvent(terminal1));
    });

    test('Removing of a terminal is correct', () {
      final terminal1 = TerminalData('https://example.com', '');
      final terminal2 = TerminalData('https://example1.com', '');
      final List<TerminalsManagerState> expected = [
        InitialTerminalsManagerState(),
        AddedTerminalsManagerState([terminal1], terminal1),
        AddedTerminalsManagerState([terminal1, terminal2], terminal2),
        RemovedTerminalsManagerState([terminal2], terminal2),
        EmptyTerminalsManagerState()
      ];
      expectLater(terminalsBloc.state, emitsInOrder(expected));
      terminalsBloc.dispatch(AddTerminalsManagerEvent(terminal1));
      terminalsBloc.dispatch(AddTerminalsManagerEvent(terminal2));
      terminalsBloc.dispatch(RemoveTerminalsManagerEvent(terminal1));
      terminalsBloc.dispatch(RemoveTerminalsManagerEvent(terminal2));
    });
  });
}
