import 'package:wetonomy/screens/groups_members/models/permission.dart';

class ContractPermissions{
  final String contractName;
  final String contractAddress;
  final List<Permission> permissions;

  ContractPermissions(this.contractName, this.contractAddress, this.permissions);
}