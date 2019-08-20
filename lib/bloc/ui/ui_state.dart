import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class UiState extends Equatable {
  final bool leftDrawerOpened;

  UiState({@required this.leftDrawerOpened}) : super([leftDrawerOpened]);
}
