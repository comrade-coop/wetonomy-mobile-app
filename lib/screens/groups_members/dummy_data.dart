import 'package:members/models/contract_permission.dart';
import 'package:members/models/group.dart';
import 'package:members/models/member.dart';

List<ContractPermissions> contractPermissions = [
  ContractPermissions("DebtTokenManager", "0x71C7656EC7ab88b098defB75151", ["Mint", "Burn", "Transfer"]),
  ContractPermissions("DebtTokenManager", "0x71C7656EC7ab88b098defB75151", ["Mint", "Burn", "Transfer"]),
  ContractPermissions("DebtTokenManager", "0x71C7656EC7ab88b098defB75151", ["Mint", "Burn", "Transfer"])
];

List<Member> members = [
  Member("Peter QuickQuick", "0x71C7656EC7ab88b098defB75151", "https://studyabroad.bg/wp-content/uploads/2020/04/shutterstock1490034536.jpg",["Dev", "Coop"]),
  Member("John Doe", "0x71C7656EC7ab88b098defB75151", "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg", ["Dev", "Coop"]),
  Member("Leonardo Di Caprio", "0x71C7656EC7ab88b098defB75151", "https://studyabroad.bg/wp-content/uploads/2020/04/shutterstock1490034536.jpg",["Dev", "Coop"]),
  Member("John Doe", "0x71C7656EC7ab88b098defB75151", "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg", ["Dev", "Coop"]),
];

List<Group> groups = [
  Group("Developers","0x71C7656EC7ab88b098defB75151", members, contractPermissions),
  Group("Marketing","0x71C7656EC7ab88b098defB75151", members, contractPermissions),
  Group("Gouvernance","0x71C7656EC7ab88b098defB75151", members, contractPermissions),
  Group("Gouvernance","0x71C7656EC7ab88b098defB75151", members, contractPermissions),
];