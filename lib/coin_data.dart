import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '053A5FBE-AD2C-4648-9338-D760E3DFA5AA';

final List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

final List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String cryptoCurrency in cryptoList) {
      String requestURL =
          'https://rest.coinapi.io/v1/exchangerate/$cryptoCurrency/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);
      String data = response.body;
      if (response.statusCode == 200) {
        var rateValue = jsonDecode(data)['rate'];
        cryptoPrices[cryptoCurrency] = rateValue.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with get request';
      }
    }
    return cryptoPrices;
  }
}
