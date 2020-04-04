import 'dart:convert';
import 'DTOs/employee_DTO.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditEmployee extends StatelessWidget {
  final Employee employee;
  EditEmployee({Key key, this.employee}) : super(key: key);
  final empNameController = TextEditingController();
  final empSalaryController = TextEditingController();
  final empAgeController = TextEditingController();
  final empDesignationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.employeeName),
      ),
      body: editView(context),
    );
  }

  Padding editView(BuildContext context) {
    empNameController.text = employee.employeeName;
    empSalaryController.text = employee.employeeSalary;
    empDesignationController.text = employee.designation;
    empAgeController.text = employee.employeeAge.toString();
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
              child: Text('Update'),
              onPressed: () {
                updateEmployee(context);
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

  Future<String> updateEmployee(BuildContext context) async {
    EmployeeDTO employeeDTO = EmployeeDTO();
    employeeDTO.employeeAge = int.parse(empAgeController.text);
    employeeDTO.employeeName = empNameController.text;
    employeeDTO.employeeSalary = empSalaryController.text;
    employeeDTO.designation = empDesignationController.text;
    employeeDTO.id = employee.id;
    employeeDTO.employeeId = employee.employeeId;
    var response = await http.put(
      'https://employees-75e1.restdb.io/rest/employees/' + employee.id,
      headers: {
        'x-apikey': 'fcdfff5d2b86713cb98988e4ef407bb4a796e',
        'Content-Type': 'application/json'
      },
      body: json.encode(employeeDTO),
      // body: jsonEncode({
      //   "employee_name": empNameController.text,
      //   "employee_salary": empSalaryController.text,
      //   "employee_age": int.parse(empAgeController.text),
      //   "designation": empDesignationController.text
      // }),
    );
    //return response.body;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to fetch employees');
    }
  }

  final TextStyle textStyle = TextStyle(fontSize: 18);
}
