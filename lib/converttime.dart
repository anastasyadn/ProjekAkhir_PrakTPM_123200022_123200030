import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HalamanConvertTime extends StatefulWidget {
  const HalamanConvertTime({super.key});

  @override
  State<HalamanConvertTime> createState() => _HalamanConvertTimeState();
}

class _HalamanConvertTimeState extends State<HalamanConvertTime> {
  late String _timezoneName;
  late Duration _timezoneOffset;
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _selectedDateTime = DateTime.now();
    _timezoneName = 'Indonesia/WIB';
    _timezoneOffset = const Duration(hours: 7);
  }

  void _changeTimezone(Duration offset, String timezone) async {
    await initializeDateFormatting(timezone, null);
    setState(() {
      _timezoneOffset = offset;
      _timezoneName = timezone;
    });
  }

  void _list(String timezone) {
    if (timezone == 'UTC') {
      _changeTimezone(const Duration(hours: 0), 'UTC');
    } else if (timezone == 'London') {
      _changeTimezone(const Duration(hours: 1), 'London');
    } else if (timezone == 'Indonesia/WIT') {
      _changeTimezone(const Duration(hours: 9), 'Indonesia/WIT');
    } else if (timezone == 'Indonesia/WITA') {
      _changeTimezone(const Duration(hours: 8), 'Indonesia/WITA');
    } else if (timezone == 'Indonesia/WIB') {
      _changeTimezone(const Duration(hours: 7), 'Indonesia/WIB');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Selected time:',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                DateFormat.jm()
                    .format(_selectedDateTime.toUtc().add(_timezoneOffset)),
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                  dropdownColor: Colors.black,
                  value: _timezoneName,
                  items: <String>[
                    'UTC',
                    'London',
                    'Indonesia/WIB',
                    'Indonesia/WITA',
                    'Indonesia/WIT'
                  ].map((String value) {
                    return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Color(0xff555555)),
                          textAlign: TextAlign.center,
                        ));
                  }).toList(),
                  onChanged: ((value) {
                    setState(() {
                      _timezoneName = value ?? 'Indonesia/WIB';
                    });
                  })),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff555555),
                      padding: EdgeInsets.symmetric(horizontal: 100)),
                  onPressed: () {
                    _list(_timezoneName);
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(color: Colors.white),
                  )),
            ]),
      )),
    );
  }
}
