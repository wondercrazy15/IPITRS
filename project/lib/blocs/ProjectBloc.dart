import 'package:project/Models/ProjectInfo.dart';
import 'package:project/Repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProjectBloc {
  final _repository = Repository();
  final _ProjectFetcher = PublishSubject<ProjectInfo>();

  Stream<ProjectInfo> get project => _ProjectFetcher.stream;

  fetchproject() async {
    ProjectInfo itemModel = await _repository.fetchProject();
    _ProjectFetcher.sink.add(itemModel);
  }

  dispose() {
    _ProjectFetcher.close();
  }
}

final bloc = ProjectBloc();