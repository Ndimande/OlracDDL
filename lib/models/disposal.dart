import 'package:database_repo/database_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/species.dart';

class Disposal extends Model {
  int estimatedGreenWeight;
  WeightUnit estimatedGreenWeightUnit;
  int individuals;
  Location location;
  Species species;
  CatchCondition disposalState;
  int fishingSetID;
  DateTime createdAt;

  Disposal({
    int id,
    @required this.estimatedGreenWeight,
    @required this.estimatedGreenWeightUnit,
    @required this.individuals,
    @required this.location,
    @required this.species,
    @required this.disposalState,
    @required this.fishingSetID,
    @required this.createdAt,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return {
      'estimated_green_weight': estimatedGreenWeight,
      'estimated_green_weight_unit': estimatedGreenWeightUnit.toString(),
      'individuals': individuals,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'species_id': species.id,
      'disposal_state_id': disposalState.id,
      'fishing_set_id': fishingSetID,
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'estimatedGreenWeight': estimatedGreenWeight,
      'estimatedGreenWeightUnit': estimatedGreenWeightUnit,
      'individuals': individuals,
      'location': location.toMap(),
      'species': species.toMap(),
      'disposalState': disposalState.toMap(),
      'fishingSetID': fishingSetID,
      'createdAt': createdAt,
    };
  }
}
