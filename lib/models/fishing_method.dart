import 'package:database_repo/database_repo.dart';
import 'package:flutter/material.dart';

class FishingMethod extends Model {
  String name;
  DateTime createdAt;
  String svgPath;
  String abbreviation;
  String portugueseName;
  String portugueseAbbreviation;

  FishingMethod({
    int id,
    this.createdAt,
    @required this.name,
    @required this.svgPath,
    @required this.abbreviation,
    @required this.portugueseName,
    @required this.portugueseAbbreviation,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'name': name,
      'svg_path': svgPath,
      'abbreviation': abbreviation,
      'portugues_name': portugueseName,
      'portugues_abbreviation': portugueseAbbreviation,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
      'svgPath': svgPath,
      'createdAt': createdAt.toIso8601String(),
      'portugueseName': portugueseName,
      'portugueseAbbreviation': portugueseAbbreviation, 
    };
  }
}
