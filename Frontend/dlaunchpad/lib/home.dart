import 'package:dlaunchpad/components/project_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import './utils/smart_contract_bridge.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //harcoded public address
  // String address = '0xaF8c55A5b4421252CA8fB6f77063c15805d7e40D';
  TextEditingController textEditingController = TextEditingController();
  String publicAddress = '';
  String _sepoliaBalance = '0';
  String trstCount = '';
  final String _ethPrice = '';
  String networth = '';
  SmartContractBridge smartContractBridge = SmartContractBridge();

  @override
  void initState() {
    // fetchBalance(address);
    smartContractBridge.initial();
    super.initState();
  }

  //fetch balance function
  Future<String> fetchBalance(String address) async {
    final response = await http.get(Uri.parse(
        'https://eth-sepolia.blockscout.com/api?module=account&action=balance&address=$address'));

    if (response.statusCode == 200) {
      // 200 OK response => then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      // print('Balance: ${json['result']}');
      setState(() {
        // _sepoliaBalance = 'Balance: ${json['result']}';
        _sepoliaBalance = json['result'];
        trstCount = _sepoliaBalance.substring(0, 5);
      });
      return 'Balance: ${json['result']}';
    } else {
      // else => exception
      throw Exception('Failed to load balance');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.grey[100],
        toolbarHeight: 100,
        title: Text(
          "dlaunchpad",
          style: GoogleFonts.electrolize(
            fontSize: 50,
          ),
        ),
        // centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: publicAddress == ''
                ? ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Enter Public Address'),
                            content: TextField(
                              controller: textEditingController,
                              decoration:
                                  const InputDecoration(hintText: 'Type here'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  setState(() {
                                    publicAddress = textEditingController.text;
                                    fetchBalance(publicAddress);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Login With Public Address",
                        style: GoogleFonts.monda(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  )
                : Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('TRST TOKENS : $trstCount'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Text(publicAddress)),
                    ],
                  ),
          )
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProjectTile(
                  publicAddress: 'publicAddress',
                  imgId: '2',
                  heading: "Polaroids NewX 2",
                  pitch:
                      "Snap, print, and share your memories with a smart camera that links physical photos to digital albums.",
                ),
                ProjectTile(
                  publicAddress: 'publicAddress',
                  imgId: '1',
                  heading: "Spicezz Authentics",
                  pitch:
                      "Spicezz Authentics: Authentic, fresh, and delicious spices from around the world delivered to your doorstep",
                ),
                ProjectTile(
                  publicAddress: 'publicAddress',
                  imgId: '3',
                  heading: "WhiteGen Shoes",
                  pitch:
                      "WhiteGen Shoes:  White sneakers that stay clean no matter what. Customizable, comfortable, and eco-friendly shoes for every occasion.",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

 // Center(
        //   child: Column(
        //     children: [
        //       ElevatedButton(
        //         onPressed: () async {
        //           List result = await smartContractBridge.getLatestPrice();
        //           // print(result[0]);
        //           setState(() {
        //             _ethPrice = result[0].toString();
        //           });
        //         },
        //         child: const Text("Get Eth Price"),
        //       ),
        //       Text(_ethPrice),
        //       Text(_sepoliaBalance),
        //       ElevatedButton(
        //         onPressed: () async {
        //           List result = await smartContractBridge
        //               .getNetWorth(BigInt.parse(_sepoliaBalance));
        //           setState(() {
        //             networth = result[0].toString();
        //           });
        //         },
        //         child: const Text("get networth"),
        //       ),
        //       Text("your networth is $networth"),
        //     ],
        //   ),
        // ),