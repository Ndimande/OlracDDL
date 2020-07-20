import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/species.dart';

class MarineLife extends Model {
  MarineLife({
    int id,
    this.estimatedWeight,
    this.estimatedWeightUnit,
    this.individuals,
    this.location,
    this.tagNumber,
    this.species,
    this.fishingSetID,
    this.condition,
    this.createdAt,
  }) : super(id: id);

  int estimatedWeight;
  WeightUnit estimatedWeightUnit;
  int individuals;
  Location location;
  String tagNumber;
  Species species;
  int fishingSetID;
  CatchCondition condition;
  DateTime createdAt;

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
    return <String, dynamic>{
      'estimated_weight': estimatedWeight,
      'estimated_weight_unit': estimatedWeightUnit.toString(),
      'individuals': individuals,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'tag_number': tagNumber,
      'species_id': species.id,
      'fishing_set_id': fishingSetID,
      'condition_id': condition.id
    };
  }

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
