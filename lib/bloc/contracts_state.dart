import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:wetonomy/models/contract.dart';

@immutable
abstract class ContractsState extends Equatable {
  ContractsState([List props = const []]) : super(props);
}

class InitialContractsState extends ContractsState {}

class LoadingContractsState extends ContractsState {}

class LoadedContractsState extends ContractsState {
  final List<Contract> contracts;

  LoadedContractsState(this.contracts) : super(contracts);
}