import './components/project_tile.dart';
import 'main.dart';
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
  TextEditingController textEditingController = TextEditingController();
  String publicAddress = '';
  String _sepoliaBalance = '0';
  String networth = '';
  SmartContractBridge smartContractBridge = SmartContractBridge();

  @override
  void initState() {
    smartContractBridge.initial();
    super.initState();
  }

  //fetch balance function
  Future<String> fetchBalance(String address) async {
    final response = await http.get(Uri.parse(
        'https://eth-sepolia.blockscout.com/api?module=account&action=balance&address=$address'));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      setState(() {
        _sepoliaBalance = json['result'];
        trstCount = int.parse(_sepoliaBalance.substring(0, 5));
      });
      return 'Balance: ${json['result']}';
    } else {
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
