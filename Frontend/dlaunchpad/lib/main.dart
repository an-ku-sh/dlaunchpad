import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //harcoded public address
  String address = '0xaF8c55A5b4421252CA8fB6f77063c15805d7e40D';
  String _sepoliaBalance = '0';

  //fetch balance function
  Future<String> fetchBalance(String address) async {
    final response = await http.get(Uri.parse(
        'https://eth-sepolia.blockscout.com/api?module=account&action=balance&address=$address'));

    if (response.statusCode == 200) {
      // 200 OK response => then parse the JSON.
      Map<String, dynamic> json = jsonDecode(response.body);
      print('Balance: ${json['result']}');
      setState(() {
        _sepoliaBalance = 'Balance: ${json['result']}';
      });
      return 'Balance: ${json['result']}';
    } else {
      // else => exception
      throw Exception('Failed to load balance');
    }
  }

  @override
  void initState() {
    fetchBalance(address);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(_sepoliaBalance),
        ),
      ),
    );
  }
}
