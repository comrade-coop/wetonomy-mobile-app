import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';
import 'package:wetonomy/models/result.dart';

abstract class StrongForceState extends Equatable {
  StrongForceState([List props = const []]) : super(props);
}

class StrongForceEmpty extends StrongForceState {}

class ActionLoading extends StrongForceState {
  final ContractAction action;

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
