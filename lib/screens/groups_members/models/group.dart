import 'package:members/models/member.dart';
import 'package:members/models/contract_permission.dart';

class Group {
  final String address;
  final String name;
  final List<Member> members; 
  final List<ContractPermissions> permissions;

  Group( this.name, this.address, this.members, this.permissions);

}