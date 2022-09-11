import 'dart:convert';
import 'package:http/http.dart' as http;
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
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '5F705A98-F89C-4E19-A9CB-C145F24B306C';
class coinData{
 Future getCoinData(selectedCurrency)async{
   Map<String , String>cryptoPrices = {};
   for(String crypto in cryptoList) {
     String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
     http.Response response = await http.get(Uri.parse(requestURL));
     if (response.statusCode == 200) {
       var decodedData = jsonDecode(response.body);
       double lastPrice = decodedData['rate'];
       cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
     } else {
       print(response.statusCode);
     }return cryptoPrices;
   }
 }
}
