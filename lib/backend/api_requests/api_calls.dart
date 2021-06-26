import 'api_manager.dart';

Future<dynamic> getEmployeesCall() => ApiManager.instance.makeApiCall(
      callName: 'Get Employees',
      apiDomain: 'holyapi.azurewebsites.net',
      apiEndpoint: 'Employee',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnResponse: true,
    );

Future<dynamic> newEmployeeCall({
  String firstName = 'foo',
  String role = 'bar',
}) =>
    ApiManager.instance.makeApiCall(
      callName: 'New Employee',
      apiDomain: 'holyapi.azurewebsites.net',
      apiEndpoint: 'Employee',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'FirstName': firstName,
        'Role': role,
      },
      returnResponse: true,
    );
