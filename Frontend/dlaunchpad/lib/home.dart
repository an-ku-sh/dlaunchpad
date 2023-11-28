import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import './utils/smart_contract_bridge.dart';

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
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                List result = await smartContractBridge.getLatestPrice();
                // print(result[0]);
                setState(() {
                  _ethPrice = result[0].toString();
                });
              },
              child: const Text("Get Eth Price"),
            ),
            Text(_ethPrice),
            Text(_sepoliaBalance),
            ElevatedButton(
              onPressed: () async {
                List result = await smartContractBridge
                    .convertEthToUsd(BigInt.parse(_sepoliaBalance));
                setState(() {
                  networth = result[0].toString();
                });
              },
              child: const Text("get networth"),
            ),
            Text("your networth is $networth"),
          ],
        ),
      ),
    );
  }
}
