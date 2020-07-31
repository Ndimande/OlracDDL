import 'package:database_repo/database_repo.dart';

class CloudCover extends Model {
  String name;
  DateTime createdAt;
  String imageString;
  String portugueseName; 

  CloudCover({
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
