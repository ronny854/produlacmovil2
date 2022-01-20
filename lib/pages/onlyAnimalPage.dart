// ignore_for_file: camel_case_types, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class onlyAnimalPage extends StatefulWidget {
  onlyAnimalPage({Key? key}) : super(key: key);

  @override
  _onlyAnimalPageState createState() => _onlyAnimalPageState();
}

class _onlyAnimalPageState extends State<onlyAnimalPage> {
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
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
                        image: AssetImage('assets/images/toro1.jpg'),
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
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
