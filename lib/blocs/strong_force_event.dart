import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:wetonomy/models/contract_action.dart';
import 'package:wetonomy/models/query.dart';

abstract class StrongForceEvent extends Equatable {
  StrongForceEvent([List props = const []]) : super(props);
}

class SendActionEvent extends StrongForceEvent {
  final ContractAction action;

  SendActionEvent({@required this.action})
      : assert(action != null),
        super([action]);
}
//
//class SendQueryEvent extends StrongForceEvent {
//  final Query query;
//
//  SendQueryEvent({@required this.query})
//      : assert(query != null),
//        super([query]);
//}
