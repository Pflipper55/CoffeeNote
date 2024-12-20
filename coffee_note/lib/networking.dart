import 'package:http/http.dart' as http;

Future<http.Response> fetchBitcoinPrice() async {
  final response =  await http.get(Uri.https("blockchain.info", "ticker"));
  return response;
}