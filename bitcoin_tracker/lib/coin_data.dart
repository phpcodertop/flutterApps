import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
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

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/'; // BTCUSD
const apiKey = 'N2M5NTI2NzgzNjcxNDgzZDg0MTQ5NjQ0NGIwZWNhYmM';

class CoinData {
  Future getCoinData({ String currency = 'USD' }) async{
    http.Response response = await http.get(Uri.parse('${coinAPIURL}BTC${currency}'), headers: {
      'x-ba-key' : apiKey
    });
    var resDecoded = jsonDecode(response.body);
    return resDecoded;
  }

}