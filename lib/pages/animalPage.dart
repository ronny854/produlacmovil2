//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, sized_box_for_whitespace, avoid_unnecessary_containers, deprecated_member_use, non_constant_identifier_names
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:produlacmovil/components/categoriesAnimals.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

import 'package:produlacmovil/pages/onlyAnimalPage.dart';
import 'package:produlacmovil/pages/subMenus/subMenuSalud.dart';

import 'animal/ingresar_editar_animal.dart';
import 'subMenus/subMenuProduccion.dart';

class AnimalPAge extends StatefulWidget {
  AnimalPAge({Key? key}) : super(key: key);

  @override
  _AnimalPAgeState createState() => _AnimalPAgeState();
}

class _AnimalPAgeState extends State<AnimalPAge> {
  ControllerGenral controller_general = new ControllerGenral();
  double value = 0;
  bool isSideBarOpen = false;
  List<dynamic> lista_animales = [];
  List<dynamic> lista_especie_animal = [];
  List<dynamic> lista_tipo_estado = [];
  List<dynamic> lista_fincas_per_id = [];
  List<dynamic> lista_fincas_segun_per_id = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Pagina Principal'),
      ),
      body: Stack(
        children: [
          animalScreen(),
          //moveAnimation(),
        ],
      ),
    );
  }

  Widget animalScreen() {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        color: Color(0XffF5F2F5),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 20.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(Icons.search),
                  Text('Buscar animales'),
                  Icon(Icons.settings),
                ],
              ),
            ),
/*             Container(
              padding: EdgeInsets.only(bottom: 10.0),
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                onPressed: () {},
                child: Container(
                  width: queryData.size.width - 100,
                  child: Text(
                    'Agregar nuevo animal',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ), */
            //categoriesWidget(),
            Container(
              padding: EdgeInsets.only(bottom: 15.0),
              child: RaisedButton(
                onPressed: () async {
                  await enviarIngresarEditar(
                      0, '', '', '', '', '', '', '', 0, 0, '', 0, 0, 0);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 35.0,
                  width: queryData.size.width - 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(35, 144, 255, 1.0),
                        Color.fromRGBO(14, 57, 102, 1.0),
                      ],
                    ),
                  ),
                  child: const Text('Agregar nuevo animal',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            Container(
              height: queryData.size.height - 200,
              width: queryData.size.width,
              child: FutureBuilder(
                future: listaAnimales(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  var _animales = snapshot.data;

                  if (!snapshot.hasData) {
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: _animales?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return animalItemWidget(
                            queryData,
                            _animales![index]['ani_imagen'],
                            _animales[index]['ani_nombre'],
                            _animales[index]['ani_codigo'],
                            _animales[index]['ani_sexo'],
                            _animales[index]['ani_raza'],
                            _animales[index]['ani_etapa'],
                            [_animales[index]]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> enviarIngresarEditar(
      int ani_id,
      String ani_codigo,
      String ani_nombre,
      String ani_sexo,
      String ani_fechanacimiento,
      String ani_imagen,
      String ani_raza,
      String ani_etapa,
      int ani_idpadre,
      int ani_idmadre,
      String ani_pesonacer,
      int esp_id,
      int fin_id,
      int ite_id) async {
    dialogCargando(context);
    lista_fincas_segun_per_id = await listaFincasSegunPerID();
    lista_fincas_per_id = listaFincasPerId(lista_fincas_segun_per_id);
    lista_animales = await listaAnimales();
    lista_especie_animal = await listaEspecieAnimal();
    lista_tipo_estado = await listaTipoEstado();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => IngresarEditarAnimal(
            ani_id,
            ani_codigo,
            ani_nombre,
            ani_sexo,
            ani_fechanacimiento,
            ani_imagen,
            ani_raza,
            ani_etapa,
            ani_idpadre,
            ani_idmadre,
            ani_pesonacer,
            esp_id,
            fin_id,
            ite_id,
            lista_animales,
            lista_especie_animal,
            lista_fincas_per_id,
            lista_tipo_estado),
      ),
    );
  }

  Container animalItemWidget(
      MediaQueryData queryData,
      String imagen,
      String nombreA,
      String codigoA,
      String sexoA,
      String raza,
      String etapa,
      List animalesLista) {
    // ignore: prefer_typing_uninitialized_variables

    return Container(
      //height: 200,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.only(bottom: 10.0),
      child: Slidable(
        direction: Axis.horizontal,
        startActionPane: ActionPane(
          extentRatio: 1.0,
          motion: ScrollMotion(),
          children: [
            itemSlidableEditarAnimal('Editar', Color(0xDE0084FF),
                Color(0xFFF1F1F1), FontAwesomeIcons.edit, animalesLista),
            itemSlidable('Eliminar', Color(0xDAFF0000), Color(0xFFFFFFFF),
                FontAwesomeIcons.trashAlt),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 1.0,
          //openThreshold: 0.9,
          motion: ScrollMotion(),
          children: [
            itemSlidable('Salud', Color(0xD52BCA2B), Color(0xFF000000),
                FontAwesomeIcons.fileMedical),
            itemSlidable('Producción', Color(0xCE6CB1FF), Color(0xFF000000),
                FontAwesomeIcons.clipboard),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => onlyAnimalPage()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    height: 140.0,
                    width: 130.0,
                    //padding: EdgeInsets.only(top: 40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(imagen), fit: BoxFit.fill),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: queryData.size.width,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadowList,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                          /*                                   bottomLeft: Radius.circular(20.0),
                                        topLeft: Radius.circular(20.0), */
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(nombreA),
                          Text("Codigo: $codigoA"),
                          Text("Sexo: $sexoA"),
                          Text("Raza: $raza"),
                          Text("Etapa: $etapa"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SlidableAction itemSlidable(
      String textItem, Color colorFondo, Color colorTexto, IconData iconoItem) {
    return SlidableAction(
      // An action can be bigger than the others.
      flex: 1,
      onPressed: doNothing,
      backgroundColor: colorFondo,
      foregroundColor: colorTexto,
      icon: iconoItem,
      label: textItem,
    );
  }

  SlidableAction itemSlidableEditarAnimal(String textItem, Color colorFondo,
      Color colorTexto, IconData iconoItem, List animales) {
    return SlidableAction(
      // An action can be bigger than the others.
      flex: 1,
      onPressed: (context) async {
        await enviarIngresarEditar(
            animales[0]['ani_id'],
            animales[0]['ani_codigo'],
            animales[0]['ani_nombre'],
            animales[0]['ani_sexo'],
            animales[0]['ani_fechanacimiento'],
            animales[0]['ani_imagen'],
            animales[0]['ani_raza'],
            animales[0]['ani_etapa'],
            animales[0]['ani_idpadre'],
            animales[0]['ani_idmadre'],
            animales[0]['ani_pesonacer'],
            animales[0]['esp_id'],
            animales[0]['fin_id'],
            animales[0]['ite_idtipoestado']);
      },
      backgroundColor: colorFondo,
      foregroundColor: colorTexto,
      icon: iconoItem,
      label: textItem,
    );
  }

  Container categoriesWidget() {
    return Container(
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowList,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    categories[index]['iconPath'],
                    height: 50.0,
                    width: 50.0,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 18.0, top: 5.0),
                    child: Text(categories[index]['name'])),
              ],
            ),
          );
        },
      ),
    );
  }

  void doNothing(BuildContext context) {
    // ignore: avoid_print
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SubMenuSalud()),
    );
    print('hola');
  }

  Future<dynamic> dialogCargando(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Container(
          width: 200,
          height: 100,
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20), child: Text('Cargando...'))
            ],
          ),
        ),
      ),
    );
  }
}
