import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class SmartContractBridge {
  late Web3Client web3client;
  late http.Client httpClient;
  final contractAddress = dotenv.env['CONTRACT_ADDRESS'];

  void initial() {
    httpClient = http.Client();
    String infuraApi = dotenv.env['INFURA_RPC']!;
    web3client = Web3Client(infuraApi, httpClient);
  }

  Future<String> getLatestPriceTx() async {
    EthPrivateKey privateKeyCred =
        EthPrivateKey.fromHex(dotenv.env['METAMASK_PRIVATE_KEY']!);
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("getLatestPrice");
    final result = await web3client.sendTransaction(
        privateKeyCred,
        Transaction.callContract(
          contract: contract,
          function: etherFunction,
          parameters: [],
          maxGas: 100000,
        ),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    // print(result);
    return result;
  }

  Future<List> getLatestPrice() async {
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("getLatestPrice");
    final result = await web3client.call(
      contract: contract,
      function: etherFunction,
      params: [],
    );
    // print(result[0]);
    return result;
  }

  Future<List> getNetWorth(amount) async {
    DeployedContract contract = await getDeployedContract();
    final etherFunction = contract.function("getNetWorth");
    final result = await web3client.call(
      contract: contract,
      function: etherFunction,
      params: [amount],
    );
    // print(result[0]);
    return result;
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("lib/assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "Dlaunchpad"),
        EthereumAddress.fromHex(contractAddress!));
    return contract;
  }
}
