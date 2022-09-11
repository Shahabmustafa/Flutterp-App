import 'package:bitcoin_app/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;


class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';
  
  DropdownButton<String> AndroidDropdown(){
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList){

      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
  }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value){
          setState(() {
        selectedCurrency = value!;
        });
          },
    );
  }

  CupertinoPicker iOSPicker(){
    List<Text> PickerItems = [];
    for(String currency in currenciesList){
      PickerItems.add(Text(currency,style: TextStyle(color: Colors.white),));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: PickerItems,
    );
  }

  Map<String, String> coinValues = {};

  bool isWaiting = false;

  void getData()async{
    isWaiting = true;
    try{
      var data = await coinData().getCoinData(selectedCurrency);
      isWaiting = false;
      print(data);
      setState(() {
        coinValues = data;
      });
    }catch(e){
      print(e);
    }
  }

  @override

  void initState() {
    super.initState();
    getData();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CryptoCard(
              cryptoCurrency: 'BTC',
              value: isWaiting ? '?' : coinValues['BTC'],
              selectedCurrency: selectedCurrency,
            ),
            CryptoCard(
              cryptoCurrency: 'ETH',
              value: isWaiting ? '?' : coinValues['ETH'],
              selectedCurrency: selectedCurrency,
            ),
            CryptoCard(
              cryptoCurrency: 'LTC',
              value: isWaiting ? '?' : coinValues['LTC'],
              selectedCurrency: selectedCurrency,
            ),
          ],
        ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : AndroidDropdown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({this.value, this.selectedCurrency, this.cryptoCurrency,});

  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}


// Extra method

// Widget getPicker(){
//   if(Platform.isIOS){
//     return iOSPicker();
//   }
//     else if(Platform.isAndroid){
//     return AndroidDropdown();
//   }
// }
// Widget getPicker() {
//   return Platform.isIOS ? iOSPicker() : AndroidDropdown();
// }

