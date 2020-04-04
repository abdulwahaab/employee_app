import 'dart:convert';
// import 'dart:ffi';
// import 'package:employee_app/DTOs/employee_DTO.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'DTOs/employee_DTO.dart';

class AddEmployee extends StatelessWidget {
  final empNameController = TextEditingController();
  final empSalaryController = TextEditingController();
  final empAgeController = TextEditingController();
  final empDesignationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: addForm(context),
    );
  }

  Padding addForm(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getTextField(empNameController, 'Full Name'),
          getTextField(empSalaryController, 'Salary'),
          getTextField(empAgeController, 'Age'),
          getTextField(empDesignationController, 'Designation'),
          Center(
            child: FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Create'),
              onPressed: () {
                var response = createEmployee(context);
                print(response.toString());
              },
            ),
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
    );
  }

  Padding getTextField(TextEditingController controller, String label) =>
      Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label),
              TextField(
                controller: controller,
              ),
            ],
          ));

  Future<String> createEmployee(BuildContext context) async {
    EmployeeDTO employee = EmployeeDTO();
    employee.employeeAge = int.parse(empAgeController.text);
    employee.employeeName = empNameController.text;
    employee.employeeSalary = empSalaryController.text;
    employee.designation = empDesignationController.text;
    employee.employeeId = 34;
    var response = await http.post(
      'https://employees-75e1.restdb.io/rest/employees',
      headers: {
        'x-apikey': 'fcdfff5d2b86713cb98988e4ef407bb4a796e',
        'Content-Type': 'application/json'
      },
      // body: jsonEncode({
      //   "employee_id": employee.employeeId,
      //   "employee_name": employee.employeeName,
      //   "employee_salary": employee.employeeSalary,
      //   "employee_age": employee.employeeAge,
      //   "designation": employee.designation,
      // }),
      body: json.encode(employee.toJson()),
    );
    //return response;
    if (response.statusCode == 200 || response.statusCode == 201) {
      // final snackBar = SnackBar(
      //   content: Text('Employee created successfully!'),
      // );
      // Scaffold.of(context).showSnackBar(snackBar);
      return response.body;
    } else {
      throw Exception('Failed to fetch employees');
    }
  }
}
