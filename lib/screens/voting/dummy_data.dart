import 'package:myapp/models/contract.dart';
import 'package:myapp/models/contract_action.dart';
import 'package:myapp/models/vote.dart';

import 'models/decision.dart';

Map<String, List<Contract>> dummyContractsByTypes = {
  "TokenManager Contracts": [
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Allowance Token",
        "TokenManager Contract", [
      ContractAction("Mint Token", {"To": "string", "Amount": "double"}),
      ContractAction("Burn Token", {"Amount": "double"}),
      ContractAction("Transfer Token",
          {"From": "string", "To": "string", "Amount": "double"}),
    ]),
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Contributin Token",
        "TokenManager Contract", [
      ContractAction("Mint Token", {"To": "string", "Amount": "double"}),
      ContractAction("Burn Token", {"Amount": "double"}),
      ContractAction("Transfer Token",
          {"From": "string", "To": "string", "Amount": "double"}),
    ]),
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Allowance Token",
        "TokenManager Contract", [
      ContractAction("Mint Token", {"To": "string", "Amount": "double"}),
      ContractAction("Burn Token", {"Amount": "double"}),
      ContractAction("Transfer Token",
          {"From": "string", "To": "string", "Amount": "double"}),
    ]),
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Contributin Token",
        "TokenManager Contract", [
      ContractAction("Mint Token", {"To": "string", "Amount": "double"}),
      ContractAction("Burn Token", {"Amount": "double"}),
      ContractAction("Transfer Token",
          {"From": "string", "To": "string", "Amount": "double"}),
    ]),
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Allowance Token",
        "TokenManager Contract", [
      ContractAction("Mint Token", {"To": "string", "Amount": "double"}),
      ContractAction("Burn Token", {"Amount": "double"}),
      ContractAction("Transfer Token",
          {"From": "string", "To": "string", "Amount": "double"}),
    ]),
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Contributin Token",
        "TokenManager Contract", [
      ContractAction("Mint Token", {"To": "string", "Amount": "double"}),
      ContractAction("Burn Token", {"Amount": "double"}),
      ContractAction("Transfer Token",
          {"From": "string", "To": "string", "Amount": "double"}),
    ]),
  ],
  "Bounty Contracts": [
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Bounty Factory",
        "Bounty Contract", [
      ContractAction(
          "Create new bounty", {"Description": "string", "Reward": "string"}),
      ContractAction(
          "Remove bounty", {"Description": "string", "Reward": "string"}),
      ContractAction(
          "Update bounty", {"Description": "string", "Reward": "string"}),
    ]),
  ],
  "Voting Contracts": [
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Central Voting",
        "Voting Contract", [
      ContractAction("Create new vote", {"Description": "string"}),
      ContractAction("Vote", {"Id": "string", "Vote": "bool"}),
    ]),
  ],
  "Group Contracts": [
    Contract("0xBB9bc244D798123fDe783fCc1C72d3Bb8C189413", "Developer Group",
        "Group Contract", [
      ContractAction("Add member", {}),
      ContractAction("Remove member", {}),
      ContractAction("Add permission", {}),
      ContractAction("Remove permission", {}),
    ]),
  ],
};

List<String> dummyContractsTypes = [
  "TokenManager Contracts",
  "Bounty Contracts",
  "Voting Contracts",
  "Group Contracts",
];

List<Vote> entries = [
  Vote("Ioan Stoianov", "yes"),
  Vote("Petar Ivanov", "no"),
  Vote("Ioan Stoianov", "yes"),
  Vote("Ioan Stoianov", "yes"),
  Vote("Petar Ivanov", "no"),
  Vote("Petar Ivanov", "no"),
  Vote("Ioan Stoianov", "yes"),
  Vote("Ioan Stoianov", "yes"),
  Vote("Petar Ivanov", "no"),
  Vote("Petar Ivanov", "no"),
  Vote("Petar Ivanov", "no"),
];

List<Vote> yes3 = [
  Vote("Ioan Stoianov", "yes"),
  Vote("Ioan Stoianov", "yes"),
  Vote("Ioan Stoianov", "yes"),
];

List<Vote> no3 = [
  Vote("Ioan Stoianov", "no"),
  Vote("Ioan Stoianov", "no"),
  Vote("Ioan Stoianov", "no"),
];

List<Decision> dummyDecisions = [
  Decision('', 'Let\'s just go to the Moon', null, entries, ["Ioan Stoianov"]),
  Decision(
      '',
      'Bulgaria on 3 seas',
      null,
      [...yes3, ...yes3, ...yes3, ...yes3 , ...yes3],
      ["Ioan Stoianov", "Executable", "Poll", "Update", "Horizontal Scroll"]),
  Decision('', 'Change Comrade Cooperative\'s name to Stalin Cooperative', null,
      [...entries, ...no3, ...yes3], ["Ioan Stoianov", "Group"]),
  
  Decision('', 'What\'s going on here', null, [...entries, ...no3, ...no3],
      ["Ioan Stoianov"]),
  Decision('', 'Change Comrade Cooperative\'s name to Stalin Cooperative', null,
      [...no3, ...no3, ...no3], ["Poll", "Horizontal Scroll"]),
];
