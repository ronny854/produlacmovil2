import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart'
    hide Alignment, Column, Row, Border;

class PersonaView extends StatefulWidget {
  PersonaView({Key? key}) : super(key: key);

  @override
  _PersonaViewState createState() => _PersonaViewState();
}

class _PersonaViewState extends State<PersonaView> {
  List<Employee> _employees = <Employee>[];
  late EmployeeDataSource _employeeDataSource;
  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  @override
  @override
  void initState() {
    super.initState();
    _employees = _getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employeeData: _employees);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: const Text('Lista de Usuarios'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SfDataGrid(
              key: _key,
              source: _employeeDataSource,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'ID',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'Name',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Name'))),
                GridColumn(
                    columnName: 'Designation',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Designation',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Salary',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Salary'))),
                GridColumn(
                    columnName: 'opciones',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('opciones'))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Employee> _getEmployeeData() {
    return <Employee>[
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
    ];
  }
}

class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Employee> employeeData}) {
    _employeeData = employeeData
        .map<DataGridRow>((Employee e) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<String>(
                  columnName: 'Designation', value: e.designation),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
              DataGridCell<MaterialButton>(
                  columnName: "opciones",
                  value: MaterialButton(
                    child: Text('editar'),
                    onPressed: () {
                      print('esta editando');
                    },
                  )),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = <DataGridRow>[];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((DataGridCell cell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(cell.value.toString()),
      );
    }).toList());
  }
}
