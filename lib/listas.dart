import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:intl/intl.dart';

ControllerGenral controller_general = ControllerGenral();

Future<List<dynamic>> listaFincasSegunPerID() async {
  List lista_fincas_segun_per_id = await controller_general.httpgeneral(
      ip_server +
          "fincaPersona/fincasPorPersona/" +
          per_id_usuario_logeado.toString(),
      "GET",
      "");
  return lista_fincas_segun_per_id;
}

Future<List<dynamic>> listaTipoEstado() async {
  List lista_tipo_estado = await controller_general.httpgeneral(
      ip_server + "items/categoria/3", "GET", "");
  return lista_tipo_estado;
}

Future<List<dynamic>> listaEspecieAnimal() async {
  List lista_especie_animal =
      await controller_general.httpgeneral(ip_server + "especies", "GET", "");
  return lista_especie_animal;
}

Future<List<dynamic>> listaAnimales() async {
  List lista_animales =
      await controller_general.httpgeneral(ip_server + "animales", "GET", "");
  return lista_animales;
}

List<dynamic> listaFincasPerId(List<dynamic> lista_fincas_segun_per_id) {
  List lista_fincas_per_id = [];
  for (var item in lista_fincas_segun_per_id) {
    lista_fincas_per_id.add(item['tbl_finca']);
  }
  return lista_fincas_per_id;
}

Future<List<dynamic>> listaprodIndividual(String ani_id) async {
  
  List lista =
      await controller_general.httpgeneral(ip_server + "prodIndividual/"+ani_id, "POST", "");
  return lista;
}
Future<List<dynamic>> listaprodGlobal(String fin_id) async {
  
  List lista =
      await controller_general.httpgeneral(ip_server + "prodGlobal/fechas/"+fin_id, "GET", "");
  return lista;
}

Future<List<dynamic>> listapersonas() async {
  
  List lista =
      await controller_general.httpgeneral(ip_server + "personas", "GET", "");
  return lista;
}

Future<List<dynamic>> listaTodaslasfincas() async {
  
  List lista =
      await controller_general.httpgeneral(ip_server + "fincas", "GET", "");
  return lista;
}

