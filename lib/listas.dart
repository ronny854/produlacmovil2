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

Future<List<dynamic>> listaprodIndividual(String ani_id,String fecha_inicio, String fecha_fin) async {
  String body = jsonEncode({
    "fecha_inicio":fecha_inicio,
    "fecha_fin":fecha_fin
  });
  List lista_animales =
      await controller_general.httpgeneral(ip_server + "prodIndividual/"+ani_id, "POST", body);
  return lista_animales;
}

List retornar_inicio_fin_fecha(DateTime fecha) {
    if (fecha.month == 1 ||
        fecha.month == 3 ||
        fecha.month == 5 ||
        fecha.month == 7 ||
        fecha.month == 8 ||
        fecha.month == 10 ||
        fecha.month == 12) {
      String dia_inicio = "01";
      String Mes = fecha.month.toString();
      String anio = fecha.year.toString();
      String dia_fin = "31";
      if (fecha.month >= 10) {
        return [
          DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(anio + "-" + Mes + "-" + dia_inicio)),
          DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(anio + "-" + Mes + "-" + dia_fin))
        ];
      } else {
        return [
          DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(anio + "-0" + Mes + "-" + dia_inicio)),
          DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(anio + "-0" + Mes + "-" + dia_fin))
        ];
      }
    } else {
      if (fecha.month == 2) {
        String dia_inicio = "01";
        String Mes = fecha.month.toString();
        String anio = fecha.year.toString();
        String dia_fin = "28";
        if (((fecha.year % 4 == 0) &&
            ((fecha.year % 100 != 0) || (fecha.year % 400 == 0)))) {
          dia_fin = "29";
        }
        return [
          DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(anio + "-0" + Mes + "-" + dia_inicio)),
          DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(anio + "-0" + Mes + "-" + dia_fin))
        ];
      } else {
        if (fecha.month == 4 ||
            fecha.month == 6 ||
            fecha.month == 9 ||
            fecha.month == 11) {
          String dia_inicio = "01";
          String Mes = fecha.month.toString();
          String anio = fecha.year.toString();
          String dia_fin = "31";
          if (fecha.month >= 10) {
            return [
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(anio + "-" + Mes + "-" + dia_inicio)),
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(anio + "-" + Mes + "-" + dia_fin))
            ];
          } else {
            return [
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(anio + "-0" + Mes + "-" + dia_inicio)),
              DateFormat('yyyy-MM-dd')
                  .format(DateTime.parse(anio + "-0" + Mes + "-" + dia_fin))
            ];
          }
        }
      }
    }

    return [];
  }
