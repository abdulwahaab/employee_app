class Employee {
  String id;
  int employeeId;
  String employeeName;
  String employeeSalary;
  int employeeAge;
  String profileImage;
  String designation;

  Employee(this.id, this.employeeId, this.employeeName, this.employeeSalary,
      this.employeeAge, this.profileImage, this.designation);

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      json['_id'] as String,
      json['employee_id'] as int,
      json['employee_name'] as String,
      json['employee_salary'] as String,
      json['employee_age'] as int,
      json['profile_image'] as String,
      json['designation'] as String,
    );
  }
}

class EmployeeDTO {
  String id;
  int employeeId;
  String employeeName;
  String employeeSalary;
  int employeeAge;
  String profileImage;
  String designation;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    data['employee_salary'] = this.employeeSalary;
    data['employee_age'] = this.employeeAge;
    data['designation'] = this.designation;
    return data;
  }
}
// class EmployeeData {
//   String status;
//   List<Employee> employees;

//   EmployeeData(this.status, [this.employees]);

//   factory EmployeeData.fromJson(dynamic json) {
//     var tagObjsJson = json['data'] as List;
//     List<Employee> _employees = tagObjsJson
//         .map((employeeJson) => Employee.fromJson(employeeJson))
//         .toList();

//     return EmployeeData(json['status'] as String, _employees);
//   }
// }

// class Employee {
//   String id;
//   String employeeName;
//   String employeeSalary;
//   String employeeAge;
//   String profileImage;

//   Employee(this.id, this.employeeName, this.employeeSalary, this.employeeAge,
//       this.profileImage);

//   factory Employee.fromJson(dynamic json) {
//     return Employee(
//       json['id'] as String,
//       json['employee_name'] as String,
//       json['employee_salary'] as String,
//       json['employee_age'] as String,
//       json['profile_image'] as String,
//     );
//   }
// }
