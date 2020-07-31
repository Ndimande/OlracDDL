import 'package:database_repo/database_repo.dart';

class MoonPhase extends Model {
  String name;
  DateTime createdAt;
  String imageString;
  String portugueseName; 

  MoonPhase({
    int id,
    this.name,
    this.createdAt,
    this.imageString,
    this.portugueseName, 
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'image_string': imageString,
      'portuguese_name': portugueseName,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'imageString': imageString,
      'name': name,
      'createdAt': createdAt,
      'portugueseName': portugueseName, 
    };
  }
}
