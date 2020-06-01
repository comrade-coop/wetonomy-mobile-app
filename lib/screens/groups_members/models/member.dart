import 'contract_permissions.dart';

class Member{
  final String name;
  final String address;
  final String iconAddress;
  final List<String> groups;
  final List<ContractPermissions> permissions;

  Member(this.name, this.address, this.iconAddress, this.groups, this.permissions);
}