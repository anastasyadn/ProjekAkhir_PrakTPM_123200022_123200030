import 'package:flutter/material.dart';

class HalamanConvertMoney extends StatefulWidget {
  const HalamanConvertMoney({super.key});

  @override
  State<HalamanConvertMoney> createState() => _HalamanConvertMoneyState();
}

class _HalamanConvertMoneyState extends State<HalamanConvertMoney> {
  late String pilihan1;
  late String pilihan2;
  late String _result;
  late double temp;

  late String _input;

  @override
  void initState() {
    super.initState();
    pilihan1 = 'IDR';
    pilihan2 = 'IDR';
    _result = '';
    _input = '';
    temp = 0;
  }

  void _hasil() {
    if (pilihan1 == 'IDR') {
      // dari IDR ke mata uang lain
      if (pilihan2 == 'IDR') {
        setState(() {
          temp = double.parse(_input);
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'USD') {
        setState(() {
          temp = double.parse(_input) / 14200;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'SGD') {
        setState(() {
          temp = double.parse(_input) / 11000;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'MYR') {
        setState(() {
          temp = double.parse(_input) / 3200;
          _result = temp.toStringAsFixed(4);
        });
      }
    } else if (pilihan1 == 'USD') {
      // dari USD ke mata uang lain
      if (pilihan2 == 'USD') {
        setState(() {
          temp = double.parse(_input);
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'IDR') {
        setState(() {
          temp = double.parse(_input) * 14200;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'SGD') {
        setState(() {
          temp = double.parse(_input) * 1.34;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'MYR') {
        setState(() {
          temp = double.parse(_input) * 4.54;
          _result = temp.toStringAsFixed(4);
        });
      }
    } else if (pilihan1 == 'SGD') {
      // dari SGD ke mata uang lain
      if (pilihan2 == 'SGD') {
        setState(() {
          temp = double.parse(_input);
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'IDR') {
        setState(() {
          temp = double.parse(_input) * 11000;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'USD') {
        setState(() {
          temp = double.parse(_input) * 0.74;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'MYR') {
        setState(() {
          temp = double.parse(_input) * 3.38;
          _result = temp.toStringAsFixed(4);
        });
      }
    } else if (pilihan1 == 'MYR') {
      // dari MYR ke mata uang lain
      if (pilihan2 == 'MYR') {
        setState(() {
          temp = double.parse(_input);
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'IDR') {
        setState(() {
          temp = double.parse(_input) * 3200;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'USD') {
        setState(() {
          temp = double.parse(_input) * 0.22;
          _result = temp.toStringAsFixed(4);
        });
      } else if (pilihan2 == 'SGD') {
        setState(() {
          temp = double.parse(_input) * 0.3;
          _result = temp.toStringAsFixed(4);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Colors.black),
            onChanged: (value) {
              setState(() {
                _input = value;
              });
            },
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                labelText: "Input Jumlah Uang",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black))),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: pilihan1,
                  items:
                      <String>['IDR', 'USD', 'SGD', 'MYR'].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.grey),
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      pilihan1 = value ?? 'IDR';
                    });
                  })),
              DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: pilihan2,
                  items:
                      <String>['IDR', 'USD', 'SGD', 'MYR'].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child:
                            Text(value, style: TextStyle(color: Colors.grey)));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      pilihan2 = value ?? 'IDR';
                    });
                  })),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff555555),
                  padding: EdgeInsets.symmetric(horizontal: 100)),
              onPressed: () {
                print(pilihan1);
                print(pilihan2);
                print(_input);
                _hasil();
              },
              child: Text(
                "Convert",
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(
            height: 15,
          ),
          Text(
            _result,
            style: TextStyle(fontSize: 20, color: Colors.black),
          )
        ]),
      )),
    );
  }
}
