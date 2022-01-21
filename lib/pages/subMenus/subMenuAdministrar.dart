// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubMenuAdministrar extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SubMenuAdministrar({Key? key}) : super(key: key);

  @override
  _SubMenuAdministrarState createState() => _SubMenuAdministrarState();
}

class _SubMenuAdministrarState extends State<SubMenuAdministrar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Administrador'),
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
    title: "Agregar Usuario",
    img: "assets/images/vacaOrd.png",
    ruta: 'tratamiento',
  );

  Items item2 = Items(
    title: "Ver usuarios",
    img: "assets/images/registrado.png",
    ruta: 'personasView',
  );
  Items item3 = Items(
    title: "Catalogo",
    img: "assets/images/map.png",
    ruta: 'vacunar',
  );
  Items item4 = Items(
    title: "Item Catalogo",
    img: "assets/images/festival.png",
    ruta: 'vacunar',
  );
  Items item5 = Items(
    title: "Agregar Finca",
    img: "assets/images/todo.png",
    ruta: 'vacunar',
  );
  /* Items item6 = Items(
    title: "Settings",
    img: "assets/images/setting.png",
  ); */

  @override
  Widget build(BuildContext context) {
    List<Items> listaAdmin = [item1, item2, item3, item4, item5];
    List<Items> listaDueno = [item1, item2];
    var color = 0xFF70C3FA;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: listaAdmin.map((data) {
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
