
import 'package:myapp/models/vote.dart';
import 'contract_action.dart';

class Decision {
  final String address;
  final String heading;
  // final String type;
  final ContractAction actions;
  final List<Vote> votes;
  final List<String> batches;
  int positiveVotesCount;
  Decision(this.address, this.heading, this.actions, this.votes, this.batches){
    this.positiveVotesCount=this.votes.where((element)=>element.vote =="yes").length;
  }
}
