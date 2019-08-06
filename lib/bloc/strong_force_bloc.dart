
import 'package:bloc/bloc.dart';
import 'package:wetonomy/bloc/strong_force_event.dart';
import 'package:wetonomy/bloc/strong_force_state.dart';
import 'package:wetonomy/models/result.dart';
import 'package:wetonomy/repositories/strongforce_repository.dart';

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

//    if (event is SendQueryEvent) {
//      yield QueryLoading(event.query);
//      Result result = await repository.sendQuery(event.query);
//      yield QueryApplied(result: result);
//    }
  }
}
