// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/pages/tratamiento/ingresar_editar_tratamiento.dart';
import 'package:produlacmovil/pages/vacuna/ingresar_editar_vacuna.dart';

import '../../listas.dart';

class SubMenuSalud extends StatefulWidget {
  SubMenuSalud({Key? key}) : super(key: key);

  @override
  _SubMenuSaludState createState() => _SubMenuSaludState();
}

class _SubMenuSaludState extends State<SubMenuSalud> {
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
        title: Text('Menú Producción del Animal'),
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
    title: "Tratamiento Animal",
    img: "assets/images/registroMedicos.png",
    ruta: 'tratamiento',
  );

  Items item2 = Items(
    title: "Vacunar Animal",
    img: "assets/images/jeringuilla.png",
    ruta: 'vacunar',
  );
  Items item3 = Items(
    title: "Ver tratamiento Animal",
    img: "assets/images/registroMedicos.png",
    ruta: 'verTratamiento',
  );

  Items item4 = Items(
    title: "Ver vacunas Animal",
    img: "assets/images/jeringuilla.png",
    ruta: 'verVacunas',
  );

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
                //Navigator.pushNamed(context, data.ruta);
                //print('enviar a ruta ' + data.ruta);
                // ignore: non_constant_identifier_names
                List<dynamic> lista_animales = await listaAnimales();
                if (data.ruta == 'tratamiento') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngresarEditarTratamiento(
                          0,
                          '',
                          animalesLista[0]['ani_id'],
                          '',
                          '',
                          '',
                          '',
                          lista_animales),
                    ),
                  );
                } else if (data.ruta == 'vacunar') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IngresarEditarVacuna(
                          0,
                          '',
                          animalesLista[0]['ani_id'],
                          '',
                          '',
                          '',
                          lista_animales),
                    ),
                  );
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
