// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubMenuVentas extends StatefulWidget {
  SubMenuVentas({Key? key}) : super(key: key);

  @override
  _SubMenuVentasState createState() => _SubMenuVentasState();
}

class _SubMenuVentasState extends State<SubMenuVentas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Ventas'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          GridDashboard()
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Realizar Venta",
    img: "assets/images/vacaOrd.png",
    ruta: 'tratamiento',
  );

  Items item2 = Items(
    title: "Ver ventas",
    img: "assets/images/registrado.png",
    ruta: 'vacunar',
  );
  /* Items item3 = Items(
    title: "Deceso",
    img: "assets/images/map.png",
    ruta: 'vacunar',
  );
  Items item4 = Items(
    title: "Parto",
    img: "assets/images/festival.png",
    ruta: 'vacunar',
  );
 Items item5 = Items(
    title: "To do",
    img: "assets/images/todo.png",
  );
  Items item6 = Items(
    title: "Settings",
    img: "assets/images/setting.png",
  ); */

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2];
    var color = 0xFF70C3FA;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, data.ruta);
                //print('enviar a ruta ' + data.ruta);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(color),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 80,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  String ruta;
  Items({required this.title, required this.img, required this.ruta});
}
