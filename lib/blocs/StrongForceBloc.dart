import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wetonomy/models/action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/result.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';

abstract class StrongForceEvent extends Equatable {
  StrongForceEvent([List props = const []]) : super(props);
}

class SendActionEvent extends StrongForceEvent {
  final Action action;

  SendActionEvent({@required this.action})
      : assert(action != null),
        super([action]);
}

class SendQueryEvent extends StrongForceEvent {
  final Query query;

  SendQueryEvent({@required this.query})
      : assert(query != null),
        super([query]);
}

abstract class StrongForceState extends Equatable {
  StrongForceState([List props = const []]) : super(props);
}

class StrongForceEmpty extends StrongForceState {}

class ActionLoading extends StrongForceState {
  final Action action;

  ActionLoading(this.action)
      : assert(action != null),
        super([action]);
}

class QueryLoading extends StrongForceState {
  final Query query;

  QueryLoading(this.query)
      : assert(query != null),
        super([query]);
}

class ActionApplied extends StrongForceState {
  final Result result;

  ActionApplied({@required this.result})
      : assert(result != null),
        super([result]);
}

class QueryApplied extends StrongForceState {
  final Result result;

  QueryApplied({@required this.result})
      : assert(result != null),
        super([result]);
}

class StrongForceBloc extends Bloc<StrongForceEvent, StrongForceState> {
  final StrongForceRepository repository;

  StrongForceBloc(this.repository) : assert(repository != null);

  @override
  StrongForceState get initialState => StrongForceEmpty();

  @override
  Stream<StrongForceState> mapEventToState(StrongForceEvent event) async* {
    if (event is SendActionEvent) {
      yield ActionLoading(event.action);
      Result result = await repository.sendAction(event.action);
      yield ActionApplied(result: result);
    }

    if (event is SendQueryEvent) {
      yield QueryLoading(event.query);
      Result result = await repository.sendQuery(event.query);
      yield QueryApplied(result: result);
    }
  }
}
