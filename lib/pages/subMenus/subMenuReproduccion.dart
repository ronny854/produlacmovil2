// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/pages/deceso/ingresar_editar_deceso.dart';
import 'package:produlacmovil/pages/inseminacion/ingresar_editar_inseminacion.dart';
import 'package:produlacmovil/pages/partoaborto/ingresareditaraborto.dart';
import 'package:produlacmovil/pages/partoaborto/ingresareditarparto.dart';

import '../../listas.dart';

class SubMenuReproduccion extends StatefulWidget {
  SubMenuReproduccion({Key? key}) : super(key: key);

  @override
  _SubMenuReproduccionState createState() => _SubMenuReproduccionState();
}

class _SubMenuReproduccionState extends State<SubMenuReproduccion> {
  List animalesLista = [];
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      animalesLista = ModalRoute.of(context)!.settings.arguments as List;
      //var listaA = jsonDecode(objeto);
      print(animalesLista[0]['ani_id']);
    }
    return Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Menú Reproducción del Animal'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          GridDashboard(animalesLista)
        ],
      ),
    );
  }
}

class GridDashboard extends StatelessWidget {
  List animalesLista = [];
  GridDashboard(this.animalesLista);
  Items item1 = Items(
    title: "Inseminación",
    img: "assets/images/vacaOrd.png",
    ruta: 'inseminacion',
  );

  Items item2 = Items(
    title: "Aborto",
    img: "assets/images/registrado.png",
    ruta: 'aborto',
  );
  Items item3 = Items(
    title: "Deceso",
    img: "assets/images/map.png",
    ruta: 'deceso',
  );
  Items item4 = Items(
    title: "Parto",
    img: "assets/images/festival.png",
    ruta: 'parto',
  );
  /* Items item5 = Items(
    title: "To do",
    img: "assets/images/todo.png",
  );
  Items item6 = Items(
    title: "Settings",
    img: "assets/images/setting.png",
  ); */

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
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
              onTap: () async {
                // Navigator.pushNamed(context, data.ruta);
                List<dynamic> lista_animales = await listaAnimales();
                if (data.ruta == 'inseminacion') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngresarEditarInseminacion(
                              0,
                              '',
                              0,
                              animalesLista[0]['ani_id'],
                              '',
                              '',
                              '',
                              0,
                              0,
                              '',
                              [],
                              lista_animales)));
                } else if (data.ruta == 'aborto') {
                  print('ruta aborto');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngresarEditarAborto(
                              0, '', '', lista_animales)));
                } else if (data.ruta == 'deceso') {
                  print('ruta');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngresarEditarDeceso(
                              0, 0, '', '', '', lista_animales)));
                } else if (data.ruta == 'parto') {
                  print('ruta parto');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IngresarEditarParto(
                              0, '', '', '', lista_animales)));
                }
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
