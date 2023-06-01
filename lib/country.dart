import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tpm_projekakhir_123200022/countrymodel.dart';

class HalamanCountry extends StatefulWidget {
  const HalamanCountry({super.key});

  @override
  State<HalamanCountry> createState() => _HalamanCountryState();
}

class _HalamanCountryState extends State<HalamanCountry> {
  @override
  void initState() {
    super.initState();
    _fetchFlags();
  }

  String printMap(CountryModel countryModel) {
    // untuk mengambil data currencies
    String output = "";
    countryModel.currencies.forEach((key, value) {
      output = value.name;
    });

    return output;
  }

  Future<List<CountryModel>> _fetchFlags() async {
    // untuk mengambil data dari API
    List<CountryModel> list = [];
    final response = await http.get(Uri.parse(
        'https://restcountries.com/v3.1/all?fields=name,capital,currencies,flags'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var element in data) {
        if (element != null) {
          list.add(CountryModel.fromJson(element));
        }
      }
    } else {
      print('Failed to fetch flags.');
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _fetchFlags(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return Center(
            child: Text('No data'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              CountryModel countryModel = snapshot.data[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                    countryModel.flags.png, // menampilkan data bendera
                    width: 100,
                    height: 90,
                  ),
                  title: Text(
                      '${countryModel.name.common}'), // menampilkan nama negara
                  subtitle: Text("Currency : " +
                      '${printMap(countryModel)}'), // menampilkan currencies
                ),
              );
            },
          );
        }
      },
    ));
  }
}
