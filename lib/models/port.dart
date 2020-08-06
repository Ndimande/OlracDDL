import 'package:database_repo/database_repo.dart';
import 'package:olracddl/models/island.dart';

class Port extends Model {
  String name;
  String portugueseName;
  String island;
  DateTime createdAt;
  String code;

  Port({
    int id,
    this.name,
    this.portugueseName,
    this.island,
    this.createdAt,
    this.code
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'portuguese_name': portugueseName,
      'island_id': island,
      'code': code,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'portugueseName': portugueseName,
      'createdAt': createdAt,
      'island': island,
      'code': code, 
    };
  }
}
