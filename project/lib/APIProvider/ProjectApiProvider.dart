import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Views/constants.dart';

class ProjectApiProvider {
  Client client = Client();

  Future<ProjectInfo> fetchProject() async {
    print("entered");
    final response = await client
        .get(AppURL+"GetProjectByCode/IPI2512-01");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ProjectInfo.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}