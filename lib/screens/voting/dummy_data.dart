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
      ContractAction("Add member", {"Address": "string"}),
      ContractAction("Remove member", {"Address": "string"}),
      ContractAction("Add permission", {
        "Address": "string",
        "Action": "string",
      }),
      ContractAction(
          "Remove permission", {"Address": "string", "Action": "string"}),
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
      [...yes3, ...yes3, ...yes3, ...yes3, ...yes3],
      ["Ioan Stoianov", "Executable", "Poll", "Update", "Horizontal Scroll"]),
  Decision('', 'Change Comrade Cooperative\'s name to Stalin Cooperative', null,
      [...entries, ...no3, ...yes3], ["Ioan Stoianov", "Group"]),
  Decision('', 'What\'s going on here', null, [...entries, ...no3, ...no3],
      ["Ioan Stoianov"]),
  Decision('', 'Change Comrade Cooperative\'s name to Stalin Cooperative', null,
      [...no3, ...no3, ...no3], ["Poll", "Horizontal Scroll"]),
];

//GRAPH
class Node {
  final String value;
  final List<Node> neigs;
  bool visited = false;
  Node(this.value, this.neigs);
}

// var graph = Node(1, [
  
//   Node(4, [
//     Node(5, [Node(6, []), Node(7, [])]),
//     Node(8, [])
//   ]),
//   Node(2, [Node(3, [])]),
// ]);
// Map<String, dynamic> graph = {
//   "1": {
//     "2": {"4": null},
//     "3": {
//       "8": {"3": null},
//       "5": {
//         "6": null,
//         "7": null,
//       }
//     }
//   }
// };


// class Node {
//   final int value;
//   final List<Node> neigs;
//   int depth;
//   double height;
//   Node(this.value, this.neigs);
// }
    // while(!isEmpty){
      
    //   Node elem = queue.removeFirst();
      
      
      
    //   int siblings = elem.neigs.length;
    //   double startHeight = elem.height-size/4*(siblings+1);

    //   var a = (elem.height-startHeight)*(elem.height-startHeight);
    //   var b = (elem.depth * size * 1.5)*(elem.depth * size * 1.5);
    //   var c = sqrt(a+b);
    //   list.add(Positioned(
    //                 left: elem.depth * size * 1.5+size/2,
    //                 top: (elem.height),
    //                 child: //edge
    //                     Transform.rotate(angle: acos(a/c), child: Edge(c*2,1))),);

      
    //   elem.neigs.forEach((x)=> {
    //     x.height = startHeight, startHeight +=size*1.5,
    //     x.depth = elem.depth+1,
    //     queue.add(x)
    //   });

    //   list.add(Positioned(
    //             left: elem.depth * size * 1.5,
    //             top: elem.height*1.0,
    //             child: Vertex(size, elem.value)));

    //   isEmpty=queue.isEmpty;
      
    // }


// Container(
//         height: 15,
//         width: 40,
//         child: Stack(
//           children: <Widget>[
//             Positioned(
//               top:5,
//               child: Container(
//                 height: 5,
//                 width: size,
//                 // decoration: BoxDecoration(
//                 color: Colors.orange,
//                 // )
//               ),
//             ),
//             Positioned(
//                 right: 0,
//                 child: //edge
//                     Transform.rotate(
//                   angle: pi / 5,
//                   child: Container(
//                     height: 5,
//                     width: 15,
//                     color: Colors.orange,
//                   ),
//                 )),
//             Positioned(
//               right: 0,
//               bottom: 0,
//               child: //edge
//                   Transform.rotate(angle:-pi/5, child: Container(height: 5,
//             width: 15, color: Colors.orange,),))
//           ],
//         ));