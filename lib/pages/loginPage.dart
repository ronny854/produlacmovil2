//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, deprecated_member_use

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:produlacmovil/components/background.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/finca/ingresareditarfinca.dart';
import 'package:produlacmovil/pages/registerPage.dart';
import 'dart:convert';

import 'drawer/navigation_home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controllerUser = TextEditingController();
  final _controllerPassword = TextEditingController();
  bool _mostrarDialogInicio = true;
  bool _mostrarErrorUsuario = false;

  ControllerGenral controller_general = new ControllerGenral();

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets

    _controllerUser.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackGround(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '''Bienvenido a ProduLac'''.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controllerUser,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
/*               Container(
                alignment: Alignment.centerRight,
                child: const Text(
                  'Olvidaste tu contraseña?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ), */

              Visibility(
                  visible: _mostrarErrorUsuario,
                  child: Text(
                    'Contraseña o usuario incorrectos',
                    style: TextStyle(color: Colors.red),
                  )),
              const SizedBox(height: 50),
              RaisedButton(
                onPressed: () async {
                  dialogInicioSesion(context);
                  await enviarDatosLogin(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ],
                    ),
                  ),
                  child: const Text('Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '''No tienes una cuenta?''',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterPage(),
                      ),
                    ),
                    child: const Text(
                      'Registrate',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> enviarDatosLogin(BuildContext context) async {
    String encodebody = jsonEncode({
      "per_usuario": _controllerUser.text,
      "per_contraseña": _controllerPassword.text,
    });

    List datos = await controller_general.httpgeneral(
        ip_server + "login", "POST", encodebody);
    bool verificar = controller_general.errorestoken(datos);
    if (verificar) {
      Navigator.pop(context);
      print("enviar a la url del login");

      _mostrarDialogInicio = false;
      setState(() {
        _mostrarErrorUsuario = true;
      });
    } else {
      _mostrarDialogInicio = false;
      _mostrarErrorUsuario = false;
      

      List fincas_segun_per_id=await listaFincasSegunPerID();
      List fincas_per_id= listaFincasPerId(fincas_segun_per_id);

      if(fincas_per_id.length==1){
        fin_id_usuario_logeado=fincas_per_id[0]['fin_id'].toString();
      }else{
        if(fincas_per_id.length>=2){
          //ESCOGER EN QUE FINCA VA A TRABAJAR
          print("ESCOGER EN QUE FINCA VA A TRABAJAR");
        }else{
          if(fincas_per_id.length==0){
            //NO PERTENECE A NINGUNA FINCA -> ENVIAR AL LOGIN 
            print("NO PERTENECE A NINGUNA FINCA -> ENVIAR AL LOGIN ");
          }
        }
      }



      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationHomeScreen(),
        ),
      );
    }
    _controllerPassword.clear();
    _controllerUser.clear();
  }

  Future<dynamic> dialogInicioSesion(BuildContext context) {
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
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Iniciado Sesión'))
            ],
          ),
        ),
      ),
    );
  }
}
