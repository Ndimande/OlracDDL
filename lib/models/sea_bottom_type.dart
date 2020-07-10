import 'package:database_repo/database_repo.dart';

class SeaBottomType extends Model {
  String name;
  DateTime createdAt;

  SeaBottomType({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      'name': name,
    };
  }
}
