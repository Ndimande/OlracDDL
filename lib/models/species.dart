import 'package:database_repo/database_repo.dart';

class Species extends Model {
  String commonName;
  String scientificName;
  DateTime createdAt;

  Species({int id, this.commonName, this.scientificName, this.createdAt}) : super(id: id);

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      'commonName': commonName,
      'scientificName': scientificName,
    };
  }
}
