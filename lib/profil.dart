import 'dart:math';

import 'package:flutter/material.dart';

class HalamanProfil extends StatefulWidget {
  const HalamanProfil({super.key});

  @override
  State<HalamanProfil> createState() => _HalamanProfilState();
}

class _HalamanProfilState extends State<HalamanProfil> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: 
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/foto.jpg'),
                      ),
                    ),
                  ),
                  Container(
                          child: Text(
                            "Anastasya Dian Irawati",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            "123200022",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Text("Kesan : ", style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                                textAlign: TextAlign.center
                          ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "Saya cukup senang dengan pembelajaran dikelas pak bagus tidak membuat bosan karena disetiap kelas pasti ada waktu untuk breaknya",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                ),
                                textAlign: TextAlign.justify,
                          ),
                        ),
                        Text("Pesan : ", style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                                textAlign: TextAlign.center
                          ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "Semoga bapak sehat selalu agar tetap bisa membagikan ilmu kedepannya untuk mahasiswa lainnya",
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                                textAlign: TextAlign.justify
                          ),
                        ),
                ]
              ),
            )
      )
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff555555);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
