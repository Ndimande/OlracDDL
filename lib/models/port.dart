import 'package:database_repo/database_repo.dart';

class Port extends Model {
  String name;
  String portugueseName;
  DateTime createdAt;

  Port({int id, this.name, this.portugueseName, this.createdAt}) : super(id: id); 

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'portuguese_name': portugueseName,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'portugueseName' : portugueseName,
      'createdAt': createdAt,
    };
  }
}
