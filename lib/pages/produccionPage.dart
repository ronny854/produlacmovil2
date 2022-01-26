//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:produlacmovil/components/chartdefault.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_global.dart';

class ProduccionPage extends StatefulWidget {
  List lista_fecha_litros;
  ProduccionPage(this.lista_fecha_litros);

  @override
  _ProduccionPageState createState() => _ProduccionPageState();
}

class _ProduccionPageState extends State<ProduccionPage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Produccion'),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 0.5852,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: chartDefault(widget.lista_fecha_litros),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: 250.0,
            ),
            child: MaterialButton(
              onPressed: () async {
                List lista_fincas_segun_per_id = await listaFincasSegunPerID();
                List lista_fincas = listaFincasPerId(lista_fincas_segun_per_id);
                List lista_horario = await getlistaHorario();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => IngresarEditarProduccionGlobal(
                        0, "", "", "", "", "", lista_fincas, lista_horario),
                  ),
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                height: size.height * 0.0512,
                width: size.width - 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(35, 144, 255, 1.0),
                      Color.fromRGBO(14, 57, 102, 1.0),
                    ],
                  ),
                ),
                child: const Text('Agregar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
