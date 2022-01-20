//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names
import 'dart:math';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Pagina Principal'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [
              Expanded(
                child: Container(
                  width: queryData.size.width,
                  height: queryData.size.height,
                  //color: Colors.blue[600],
                  padding: EdgeInsets.only(top: 55.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/hacienda.jpg'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [Text("Finca San Antonio")],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
