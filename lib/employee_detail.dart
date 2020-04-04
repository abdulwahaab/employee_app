import 'employee_edit.dart';
import 'DTOs/employee_DTO.dart';
import 'package:flutter/material.dart';

class EmployeeDetail extends StatelessWidget {
  final Employee employee;
  EmployeeDetail({Key key, this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.employeeName),
      ),
      body: detailView(context),
    );
  }

  Padding detailView(BuildContext context) {
    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getText('Employee Name: ' + employee.employeeName),
          getText('Employee Salary: ' + employee.employeeSalary),
          getText('Employee age: ' + employee.employeeAge.toString()),
          // SizedBox.expand(
          //   child: FlatButton(
          //     color: Colors.red,
          //     textColor: Colors.white,
          //     child: Text('Edit'),
          //     onPressed: () {},
          //   ),
          // ),
          Center(
            child: FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Edit'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditEmployee(employee: employee),
                  ),
                );
              },
            ),
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
    );
  }

  Padding getText(String text) => Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Text(
          text,
          style: textStyle,
        ),
      );

  final TextStyle textStyle = TextStyle(fontSize: 18);
}
