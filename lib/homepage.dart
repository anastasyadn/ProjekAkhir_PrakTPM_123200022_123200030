import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpm_projekakhir_123200022/convertmoney.dart';
import 'package:tpm_projekakhir_123200022/converttime.dart';
import 'package:tpm_projekakhir_123200022/country.dart';
import 'package:tpm_projekakhir_123200022/profil.dart';

class Home extends StatefulWidget {
  final VoidCallback signOut;
  const Home({super.key, required this.signOut});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  int _selectedNavbar = 0;
  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  final List<String> _list = [
    "Country",
    "Konversi Mata Uang",
    "Konversi Waktu",
    "Profil"
  ];

  final List<Widget> _listMenu = [
    HalamanCountry(),
    HalamanConvertMoney(),
    HalamanConvertTime(),
    HalamanProfil(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_list[_selectedNavbar], style: TextStyle(color: Colors.black),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              signOut();
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: _listMenu[_selectedNavbar],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Country',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Konversi Uang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.punch_clock),
            label: 'Konversi Waktu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
