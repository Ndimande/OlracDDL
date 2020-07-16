import 'package:database_repo/database_repo.dart';
import 'package:flutter/material.dart';

class FishingMethod extends Model {
  String name;
  DateTime createdAt;
  String svgPath;
  String abbreviation;

  FishingMethod({
    int id,
    this.createdAt,
    @required this.name,
    @required this.svgPath,
    @required this.abbreviation,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'abbreviation': abbreviation,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'abbreviation': abbreviation,
      'svgPath': svgPath,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
