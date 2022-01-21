// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:produlacmovil/components/app_theme.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/animalPage.dart';
import 'package:produlacmovil/pages/nacimientoPage.dart';
import 'package:produlacmovil/pages/produccionPage.dart';
import 'package:produlacmovil/pages/saludPage.dart';
import 'package:produlacmovil/pages/subMenus/subMenuAdministrar.dart';
import 'package:produlacmovil/pages/subMenus/subMenuIngresos.dart';
import 'package:produlacmovil/pages/subMenus/subMenuVentas.dart';

import '../principalPage.dart';
import 'drawer_user_controller.dart';
import 'home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;
  ControllerGenral _controllerGenral = ControllerGenral();

  @override
  void initState() {
    drawerIndex = DrawerIndex.inicio;
    screenView = PrincipalPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) async {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.inicio) {
        List datos = await _controllerGenral.httpgeneral(
            ip_server + 'finca/1', 'GET', '');
        setState(() {
          screenView = PrincipalPage();
        });
      } else if (drawerIndex == DrawerIndex.animales) {
        setState(() {
          screenView = AnimalPAge();
        });
      } else if (drawerIndex == DrawerIndex.produccion) {
        setState(() {
          screenView = ProduccionPage();
        });
      } else if (drawerIndex == DrawerIndex.ventas) {
        setState(() {
          screenView = SubMenuVentas();
        });
      } else if (drawerIndex == DrawerIndex.administrar) {
        setState(() {
          screenView = SubMenuAdministrar();
        });
      } else if (drawerIndex == DrawerIndex.ingresos) {
        setState(() {
          screenView = SubMenuIngresos();
        });
      }
    }
  }
}
