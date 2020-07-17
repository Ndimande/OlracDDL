import 'package:database_repo/database_repo.dart';

class CloudType extends Model {
  String name;
  DateTime createdAt;
  String imageString;

  CloudType({
    int id,
    this.name,
    this.createdAt,
    this.imageString,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'imageString': imageString,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'imageString': imageString,
      'name': name,
      'createdAt': createdAt,
    };
  }
}
