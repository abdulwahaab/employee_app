import 'dart:async';
import 'dart:convert';
import 'employee_add.dart';
import 'employee_detail.dart';
import 'DTOs/employee_DTO.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:employee_app/employee_edit.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewState createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  List<Employee> employeeList;
  List<Employee> duplicateEmployeeList;
  var searchContrller = TextEditingController();

  @override
  void initState() {
    _fetchEmployees().then((response) {
      employeeList = response;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Employees List'),
      ),
      body: Center(child: displayView(context)),
      // body: Center(
      //   child: Column(
      //     children: <Widget>[
      //       Padding(
      //         padding: EdgeInsets.all(10),
      //         child: TextField(
      //           decoration: new InputDecoration(
      //             border: new OutlineInputBorder(
      //               borderRadius: const BorderRadius.all(
      //                 const Radius.circular(25.0),
      //               ),
      //             ),
      //             contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      //             hintStyle: new TextStyle(color: Colors.grey[800]),
      //             hintText: 'Search by name',
      //           ),
      //           controller: searchContrller,
      //           onChanged: (text) {
      //             filterSearchResults(text);
      //           },
      //         ),
      //       ),
      //       Expanded(
      //         child: displayView(context),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new AddEmployee()),
          ).then(
            (value) {
              build(context);
            },
          );
        },
      ),
    );
  }

  Widget displayView(BuildContext context) {
    return FutureBuilder<List<Employee>>(
      future: _fetchEmployees(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          employeeList = snapshot.data;
          duplicateEmployeeList = employeeList;
          return _jobsListView(employeeList);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  // Widget displayView(BuildContext context) {
  //   return FutureBuilder<List<Employee>>(
  //     future: _fetchEmployees(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         employeeList = snapshot.data;
  //         duplicateEmployeeList = employeeList;
  //         return _jobsListView(employeeList);
  //       } else if (snapshot.hasError) {
  //         return Text("${snapshot.error}");
  //       }
  //       return CircularProgressIndicator();
  //     },
  //   );
  // }

  Future<List<Employee>> _fetchEmployees() async {
    final response = await http.get(
      'https://employees-75e1.restdb.io/rest/employees',
      headers: {'x-apikey': 'fcdfff5d2b86713cb98988e4ef407bb4a796e'},
    );
    if (response.statusCode == 200) {
      var list = (json.decode(response.body) as List)
          .map((data) => new Employee.fromJson(data))
          .toList();
      // list.forEach((item) {
      //   print(item.employeeName);
      // });
      setState(() {
        employeeList = list;
        duplicateEmployeeList = list;
      });
      return list;
    } else {
      throw Exception('Failed to fetch employees');
    }
  }

  void filterSearchResults(String query) {
    List<Employee> dummySearchList = List<Employee>();
    dummySearchList.addAll(duplicateEmployeeList);
    if (query.isNotEmpty) {
      List<Employee> dummyListData = List<Employee>();
      dummySearchList.forEach((item) {
        if (item.employeeName.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        employeeList.clear();
        employeeList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        employeeList.clear();
        employeeList.addAll(duplicateEmployeeList);
      });
    }
  }

  ListView _jobsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return getListItem(data[index], context);
        });
  }

  Dismissible getListItem(Employee employeeData, BuildContext context) {
    //print(employeeData.employeeId.toString() +': ' + employeeData.id);
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: new Key(employeeData.id.toString()),
      onDismissed: (direction) {
        print(employeeData.id.toString());
        deleteEmployee(employeeData.id);
      },
      background: new Container(
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: new Align(
          alignment: Alignment.centerRight,
          child: new Text(
            'Delete',
            textAlign: TextAlign.right,
            style: new TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: _tile(employeeData, context),
    );
  }

  ListTile _tile(dynamic employeeData, BuildContext context) {
    return ListTile(
      title: Text(
        employeeData.employeeName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(employeeData.employeeSalary),
      leading: Icon(
        Icons.person,
        color: Colors.indigo,
      ),
      trailing: GestureDetector(
        child: Icon(
          Icons.edit,
          color: Colors.indigo,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditEmployee(employee: employeeData),
            ),
          );
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetail(employee: employeeData),
          ),
        );
      },
    );
  }

  Future<bool> deleteEmployee(var employeeId) async {
    final response = await http.delete(
      'https://employees-75e1.restdb.io/rest/employees/' + employeeId,
      headers: {'x-apikey': 'fcdfff5d2b86713cb98988e4ef407bb4a796e'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to fetch employees');
    }
  }
}
