import 'dart:async';

import 'package:project/APIProvider/ProjectApiProvider.dart';
import 'package:project/Models/ProjectInfo.dart';


class Repository {
  final projectApiProvider = ProjectApiProvider();

  Future<ProjectInfo> fetchProject() => projectApiProvider.fetchProject();
}