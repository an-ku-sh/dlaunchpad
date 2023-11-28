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
  String address = '0xaF8c55A5b4421252CA8fB6f77063c15805d7e40D';
  String _sepoliaBalance = '0';
  String _ethPrice = '';
  String networth = '';
  SmartContractBridge smartContractBridge = SmartContractBridge();

  @override
  void initState() {
    fetchBalance(address);
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
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Login With Public Key",
                    style: GoogleFonts.monda(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //Start of tile
                  Container(
                    height: 350,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1),
                    ),
                    child: Column(
                      children: [
                        Image.asset("lib/assets/img2.jpg"),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Polaroids NewX 2",
                          style: GoogleFonts.abel(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Snap, print, and share your memories with a smart camera that links physical photos to digital albums.",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 0.6,
                          color: Colors.grey,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.heat_pump_rounded),
                              label: const Text("Give Feedback"),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  //End of tile
                  // //Start of tile
                  // Container(
                  //   height: 350,
                  //   width: 300,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 0.1),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Image.asset("lib/assets/img1.jpg"),
                  //       const SizedBox(
                  //         height: 5,
                  //       ),
                  //       Text(
                  //         "Spicezz Authentics",
                  //         style: GoogleFonts.abel(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       const Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text(
                  //           "Spicezz Authentics: Authentic, fresh, and delicious spices from around the world delivered to your doorstep",
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Container(
                  //         height: 0.6,
                  //         color: Colors.grey,
                  //         width: double.infinity,
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           ElevatedButton.icon(
                  //             onPressed: () {},
                  //             icon: const Icon(Icons.heat_pump_rounded),
                  //             label: const Text("Give Feedback"),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // //End of tile
                  // //Start of tile
                  // Container(
                  //   height: 350,
                  //   width: 300,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 0.1),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Image.asset("lib/assets/img3.jpg"),
                  //       const SizedBox(
                  //         height: 5,
                  //       ),
                  //       Text(
                  //         "WhiteGen Shoes",
                  //         style: GoogleFonts.abel(
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //       const Padding(
                  //         padding: EdgeInsets.all(8.0),
                  //         child: Text(
                  //           "WhiteGen Shoes:  White sneakers that stay clean no matter what. Customizable, comfortable, and eco-friendly shoes for every occasion.",
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         height: 20,
                  //       ),
                  //       Container(
                  //         height: 0.6,
                  //         color: Colors.grey,
                  //         width: double.infinity,
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           ElevatedButton.icon(
                  //             onPressed: () {},
                  //             icon: const Icon(Icons.heat_pump_rounded),
                  //             label: const Text("Vote with TRST"),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  //End of tile
                ],
              ),
            ],
          ),
        )
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
        );
  }
}
