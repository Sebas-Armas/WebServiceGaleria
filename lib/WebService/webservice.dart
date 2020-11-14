import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Country {
  final String name;
  final String capital;
  final String subregion;
  final int population;

  Country({this.name, this.capital, this.subregion, this.population});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name'],
        capital: json['capital'],
        subregion: json['subregion'],
        population: json['population']
    );
  }
}

Future<List<Country>> fetchCountry() async {
  final response = await http.get('https://restcountries.eu/rest/v2/lang/es');

  var countries=List<Country>();

  if (response.statusCode == 200) {
    var countriesJason=json.decode(response.body);
    for(var countryJason in countriesJason){
      countries.add(Country.fromJson(countryJason));
    }
    return countries;
  } else {
    throw Exception('No se pueden cargar los países');
  }
}

class WebServicePage extends StatefulWidget {

  @override
  _WebServicePageState createState() => _WebServicePageState();
}

class _WebServicePageState extends State<WebServicePage> {
  List<Country> _countries=List<Country>();
  List<Country> _countriesForDisplay=List<Country>();

  @override
  void initState() {
    fetchCountry().then((value) {
      setState(() {
        _countries.addAll(value);
        _countriesForDisplay = _countries;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lectura de web service"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index){
          return index==0 ?  _searchBar() : _listItem(index-1);
        },
        itemCount:_countriesForDisplay.length+1,
      ),
    );
  }

  _searchBar(){
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        decoration: InputDecoration(hintText: 'Buscar'),
        onChanged: (text){
          text = text.toLowerCase();
          setState(() {
            _countriesForDisplay=_countries.where((country){
              var contName = country.name.toLowerCase();
              return contName.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index){
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(_countriesForDisplay[index].name,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
            Text(_countriesForDisplay[index].capital,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600),),
            Text(_countriesForDisplay[index].subregion,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600),),
            Text(_countriesForDisplay[index].population.toString(),
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600),),
          ],
        ),
      ),
    );
  }

}