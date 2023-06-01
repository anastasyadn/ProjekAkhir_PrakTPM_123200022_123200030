import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpm_projekakhir_123200022/homepage.dart';
import 'package:tpm_projekakhir_123200022/main.dart';
import 'package:tpm_projekakhir_123200022/register.dart';

class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

enum LoginStatus { notSignIn, signIn }

class _HalamanLoginState extends State<HalamanLogin> {
  // untuk menampung inputan user
  var _uname = TextEditingController();
  var _pass = TextEditingController();
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus
          .notSignIn: //kondisi ketika status tidak login bakal nampilin form login
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login.png'), fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Container(),
                SingleChildScrollView(
                  child: Container(
                    //untuk textfield username dan passwordnya
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _uname,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Username",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: _pass,
                                obscureText: !_showPassword,
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showPassword = !_showPassword;
                                      });
                                    },
                                    icon: Icon(_showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // untuk menampilkan button login
                          margin: EdgeInsets.only(left: 35, right: 35),
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(58, 67, 77, 1),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (_uname.text != "" && _pass.text != "") {
                                _onLogin();
                              } else {
                                SnackBar snackBar = SnackBar(
                                  content: Text("Tidak Boleh Ada Yang Kosong"),
                                  backgroundColor: Colors.redAccent,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          height: 40,
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return HalamanRegister();
                                  }),
                                );
                              },
                              child: Text(
                                "Tidak Punya Akun? Daftar",
                                style: TextStyle(color: Colors.black54),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        break;
      case LoginStatus
          .signIn: // kondisi ketika status login bakal ke homepage alias tdk logout
        return Home(
          signOut: signOut,
        );
        break;
    }
  }

  void _onLogin() async {
    // untuk mengkoneksikan inputan user dengan database, sekalian cek username dan password
    final response = await http.post(
        Uri.parse("http://192.168.43.49/dbtpm/users/login.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Headers": "Content-Type",
          "Referrer-Policy": "no-referrer-when-downgrade"
        },
        body: {
          "username": _uname.text,
          "pass": _pass.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String username = data['username'];
    String pass = data['pass'];
    print(_uname.text);
    if (value == 1) {
      // kalau login berhasil
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, username, pass);
      });
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return Home(
            signOut: signOut,
          );
        }),
      );
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.greenAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      // kalau login gagal
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  savePref(int value, String username, String pass) async {
    // untuk menyimpan data user
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  var value;
  getPref() async {
    // untuk mendapatkan status login user
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value") ?? 0;

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
    return;
  }

  signOut() async {
    // untuk logout agar status login user ter logout
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", 0);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return const MyApp();
      }),
    );
  }
}
