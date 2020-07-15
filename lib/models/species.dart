import 'package:database_repo/database_repo.dart';

class Species extends Model {
  String commonName;
  String scientificName;
  DateTime createdAt;

  Species({int id, this.commonName, this.scientificName, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'commonName': commonName,
      'scientificName': scientificName,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'commonName':commonName,
      'scientificName': scientificName,
    };

  }
}
