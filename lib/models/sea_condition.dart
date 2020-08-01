import 'package:database_repo/database_repo.dart';

class SeaCondition extends Model {
  String name;
  String namePortuguese;
  DateTime createdAt;
  String imageString;

  SeaCondition({
    int id,
    this.name,
    this.namePortuguese,
    this.createdAt,
    this.imageString,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'name_portuguese' : namePortuguese,
      'image_string': imageString,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'imageString': imageString,
      'name': name,
      'namePortuguese' : namePortuguese,
      'createdAt': createdAt,
    };
  }
}
