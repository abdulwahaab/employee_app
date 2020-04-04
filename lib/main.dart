import 'employee_listview.dart';
import 'package:flutter/material.dart';

void main() => runApp(EmployeeApp());

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Employees List',
      home: new HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmployeeListView();
  }
}

// class EmployeeApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Employee App',
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: Scaffold(
//         // backgroundColor: Colors.greenAccent,
//         appBar: AppBar(
//           title: Text('Employees List'),
//         ),
//         body: Center(child: EmployeeListView()),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () => () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AddEmployee()),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//class _MyHomePageState extends State<MyHomePage> {
// Expanded displayEmployees() {
//   final response =
//       http.get('http://dummy.restapiexample.com/api/v1/employees').toString();
//   var employees = EmployeeData.fromJson(json.decode(response)).employees;
//   return Expanded(
//     child: ListView.builder(
//         itemCount: employees.length,
//         itemBuilder: (BuildContext ctxt, int index) {
//           return new Text(employees[index].employee_name);
//         }),
//   );
// }

// Future<Employee> fetchEmployees() async {
//   final response =
//       await http.get('http://dummy.restapiexample.com/api/v1/employees');

//   if (response.statusCode == 200) {
//     var employeeList = Employee.fromJson(json.decode(response.body));
//     var employeeName = employeeList.data[0].employee_name;
//     return employeeList;
//   } else {
//     throw Exception('Failed to fetch employees');
//   }
// }
//}
