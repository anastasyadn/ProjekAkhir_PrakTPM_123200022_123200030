import 'package:flutter/material.dart';
import 'package:tpm_projekakhir_123200022/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HalamanRegister extends StatefulWidget {
  const HalamanRegister({super.key});

  @override
  State<HalamanRegister> createState() => _HalamanRegisterState();
}

class _HalamanRegisterState extends State<HalamanRegister> {
  //untuk menampung inputan user
  var _uname = TextEditingController();
  var _pass = TextEditingController();
  var _cpass = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _showPassword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //untuk menampilkan gambar background
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
                            height: 30,
                          ),
                          TextFormField(
                            controller: _cpass,
                            obscureText: !_showPassword,
                            style: TextStyle(),
                            decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Confirm Password",
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // untuk menampilkan button register
                      margin: EdgeInsets.only(left: 35, right: 35),
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(58, 67, 77, 1),
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (_uname.text != "" &&
                              _pass.text != "" &&
                              _cpass.text != "") {
                            if (_pass.text != _cpass.text) {
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                    "Password dan Konfirmasi Password harus sama !"),
                                backgroundColor: Colors.redAccent,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              print(_uname.text);
                              print(_pass.text);
                              _onRegister();
                            }
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
                          "DAFTAR",
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
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return HalamanLogin();
                              }),
                            );
                          },
                          child: Text(
                            "Sudah punya akun? Login",
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
  }

  void _onRegister() async {
    // untuk koneksi register ke database mysql menggunakan ip lokal
    final response = await http.post(
        Uri.parse("http://192.168.43.49/dbtpm/users/register.php"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
        },
        body: {
          "username": _uname.text,
          "pass": _pass.text
        });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    print(_uname.text);
    if (value == 1) {
      setState(() {
        Navigator.pop(context);
      });
    } else if (value == 0) {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.redAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
