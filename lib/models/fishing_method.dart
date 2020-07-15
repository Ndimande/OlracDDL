import 'package:database_repo/database_repo.dart';

class FishingMethod extends Model {
  String name;
  DateTime createdAt;

  FishingMethod({int id, this.name, this.createdAt}) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'createdAt': createdAt,
    };
  }
}
