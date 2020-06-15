import 'package:wetonomy/screens/groups_members/models/contract_permissions.dart';
import 'package:wetonomy/screens/groups_members/models/group.dart';
import 'package:wetonomy/screens/groups_members/models/member.dart';
import 'package:wetonomy/screens/groups_members/models/permission.dart';



var currentUserMetaData = Member(
    "Your Profile",
    "0x71C7656EC7ab88b098defB75150",
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTOS7KNcMLI-A9ab3kc9r83EQSpMJWjjTeNkAf1h9ebXIXlwpc6&usqp=CAU',
    ["Developers"],
    [personalContract, voting1, wetonomyToken1, developersToken]);



var personalContract = ContractPermissions("PersonalContract", "0x71C7656EC7ab88b098defB75888",[p1, p2, p3]);


var p1 =
    Permission("PersonalPermission1", "0x71C7656EC7ab88b098defB75150", ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var p2 =
    Permission("PersonalPermission2", "0x71C7656EC7ab88b098defB75150", []);
var p3 =
    Permission("PersonalPermission3", "0x71C7656EC7ab88b098defB75150", ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);


List<Member> developers = [
  Member(
      "Peter QuickQuick",
      "0x71C7656EC7ab88b098defB75151",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      [personalContract, voting1, wetonomyToken1, developersToken]),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75152",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      [personalContract, voting1, wetonomyToken1, developersToken]),
  Member(
      "Leonardo Di Caprio",
      "0x71C7656EC7ab88b098defB75153",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      [personalContract, voting1, wetonomyToken1, developersToken]),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75154",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      [personalContract, voting1, wetonomyToken1, developersToken]),
];


List<Member> marketing = [
  Member(
      "Peter QuickQuick",
      "0x71C7656EC7ab88b098defB75151",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      [voting2, wetonomyToken1, maerketingToken]),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75152",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      [voting2, wetonomyToken1, maerketingToken]),
  Member(
      "Leonardo Di Caprio",
      "0x71C7656EC7ab88b098defB75153",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      [voting2, wetonomyToken1, maerketingToken]),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75154",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      [voting2, wetonomyToken1, maerketingToken]),
];

List<Member> governance = [
  Member(
      "Peter QuickQuick",
      "0x71C7656EC7ab88b098defB75151",
      "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      ["Dev", "Coop"],
      [voting3, wetonomyToken1]),
  Member(
      "John Doe",
      "0x71C7656EC7ab88b098defB75152",
      "https://pbs.twimg.com/media/BcINeMVCIAABeWd.jpg",
      ["Dev", "Coop"],
      [voting3, wetonomyToken1]),
];

List<Member> members = [ ...developers,
  ...marketing, ...governance, currentUserMetaData
];

List<Group> groups = [
  Group("Developers", "0x71C7656EC7ab88b098defB75161", developers,
      [voting1, wetonomyToken1, developersToken]),
  Group("Marketing", "0x71C7656EC7ab88b098defB75162", marketing,
      [voting2, wetonomyToken1, maerketingToken]),
  Group("Governance", "0x71C7656EC7ab88b098defB75163", members,
      [voting3, wetonomyToken1]),
];

var voting1 = ContractPermissions("Vote", "0x71C7656EC7ab88b098defB7888",
    [vote1,initiateNewVote1]);
var vote1 = Permission("Vote", "0x71C7656EC7ab88b098defB75161",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var initiateNewVote1 = Permission(
    "InitiateNewVote",
    "0x71C7656EC7ab88b098defB75161",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);

var voting2 = ContractPermissions("Vote", "0x71C7656EC7ab88b098defB7888",
    [vote2, initiateNewVote2]);
var vote2 = Permission("Vote", "0x71C7656EC7ab88b098defB75162",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var initiateNewVote2 = Permission(
    "InitiateNewVote",
    "0x71C7656EC7ab88b098defB75162",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);

var voting3 = ContractPermissions("Vote", "0x71C7656EC7ab88b098defB7888",
    [vote3,initiateNewVote3]);
var vote3 = Permission("Vote", "0x71C7656EC7ab88b098defB75163",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var initiateNewVote3 = Permission(
    "InitiateNewVote",
    "0x71C7656EC7ab88b098defB75163",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);

var wetonomyToken1 = ContractPermissions("WetonomyTokenManager", "0x71C7656EC7ab88b098defB7888", [mint1, burn1, transfer1]);
var mint1 = Permission("Mint", "0x71C7656EC7ab88b098defB75163",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var burn1 = Permission("Burn", "0x71C7656EC7ab88b098defB75163",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var transfer1 = Permission("Transfer", "0x71C7656EC7ab88b098defB75163",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);

var developersToken = ContractPermissions("DevelopersTokenManager", "0x71C7656EC7ab88b098defB7888", [mintd, burnd, transferd]);
var mintd = Permission("Mint", "0x71C7656EC7ab88b098defB75161",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var burnd = Permission("Burn", "0x71C7656EC7ab88b098defB75161",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var transferd = Permission("Transfer", "0x71C7656EC7ab88b098defB75161",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);

var maerketingToken = ContractPermissions("DevelopersTokenManager", "0x71C7656EC7ab88b098defB7888", [mintm, burnm, transferm]);
var mintm = Permission("Mint", "0x71C7656EC7ab88b098defB75162",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var burnm = Permission("Burn", "0x71C7656EC7ab88b098defB75162",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);
var transferm = Permission("Transfer", "0x71C7656EC7ab88b098defB75162",
    ["Kevin Garsia", "Loren Ipsum", "Gloria Sanchez"]);