import 'package:wetonomy/screens/groups_members/models/permission.dart';

import './models/contract_permissions.dart';
import './models/group.dart';
import './models/member.dart';

var currentUserMetaData = Member(
    "Your Profile",
    "0xASDASDLASDKL",
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOS7KNcMLI-A9ab3kc9r83EQSpMJWjjTeNkAf1h9ebXIXlwpc6&usqp=CAU',
    [],
    []);

var mint = Permission("Mint", "0x71C7656EC7ab88b098defB75151",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var burn = Permission("Burn", "0x71C7656EC7ab88b098defB75152",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var transfer = Permission("Transfer", "0x71C7656EC7ab88b098defB75153",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);

var vote = Permission("Vote", "0x71C7656EC7ab88b098defB75154",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var initiateNewVote = Permission(
    "InitiateNewVote",
    "0x71C7656EC7ab88b098defB75151",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var changeState =
    Permission("InitiateNewVote", "0x71C7656EC7ab88b098defB75151", []);

List<ContractPermissions> contractPermissions = [
  ContractPermissions("DebtTokenManager", "0x71C7656EC7ab88b098defB75151",
      [mint, burn, transfer]),
  ContractPermissions("DebtTokenManager", "0x71C7656EC7ab88b098defB75151",
      [mint, burn, transfer]),
  ContractPermissions("DebtTokenManager", "0x71C7656EC7ab88b098defB75151",
      [mint, burn, transfer])
];

List<ContractPermissions> contractPermissions2 = [
  ContractPermissions(
      "Voting", "0x71C7656EC7ab88b098defB75151", [vote, initiateNewVote]),
  ContractPermissions("Bounty", "0x71C7656EC7ab88b098defB75151", [changeState]),
  ContractPermissions(
      "Voting", "0x71C7656EC7ab88b098defB75151", [vote, initiateNewVote]),
];

List<Member> members = [
  Member(
      "Peter QuickQuick",
      "0x71C7656EC7ab88b098defB75151",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      contractPermissions2),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75152",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      contractPermissions2),
  Member(
      "Leonardo Di Caprio",
      "0x71C7656EC7ab88b098defB75153",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      contractPermissions2),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75154",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      contractPermissions2),
];

List<Group> groups = [
  Group("Developers", "0x71C7656EC7ab88b098defB75151", members,
      contractPermissions),
  Group("Marketing", "0x71C7656EC7ab88b098defB75151", members,
      contractPermissions),
  Group("Gouvernance", "0x71C7656EC7ab88b098defB75151", members,
      contractPermissions),
  Group("Gouvernance", "0x71C7656EC7ab88b098defB75151", members,
      contractPermissions),
];
