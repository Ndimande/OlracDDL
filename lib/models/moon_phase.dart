import 'package:database_repo/database_repo.dart';

class MoonPhase extends Model {
  String name;
  DateTime createdAt;
  String imageString;

  MoonPhase({
    int id,
    this.name,
    this.createdAt,
    this.imageString,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'image_string': imageString,
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
