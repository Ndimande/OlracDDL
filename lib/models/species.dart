import 'package:database_repo/database_repo.dart';

class Species extends Model {
  String commonName;
  String scientificName;
  DateTime createdAt;
  String commonNamePortuguese;

  Species({int id, this.commonName, this.scientificName, this.createdAt, this.commonNamePortuguese}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'common_name': commonName,
      'scientific_name': scientificName,
      'common_name_portuguese' : commonNamePortuguese,

    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'commonName': commonName,
      'scientificName': scientificName,
      'commonNamePortuguese' :commonNamePortuguese,
    };
  }
}
