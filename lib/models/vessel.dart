import 'package:database_repo/database_repo.dart';

class Vessel extends Model {
  String name;
  DateTime createdAt;
  String vesselID;

  Vessel({int id, this.name, this.vesselID, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'vesselId': vesselID,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'vesselID': vesselID,
    };
  }
}
