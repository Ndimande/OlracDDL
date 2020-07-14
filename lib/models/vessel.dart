import 'package:database_repo/database_repo.dart';

class Vessel extends Model {
  String name;
  DateTime createdAt;
  int vesselId;

  Vessel({int id, this.name, this.vesselId, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'vesselId': vesselId,
    };
  }
}
