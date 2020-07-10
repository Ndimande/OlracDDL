import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';

class FishingSetEvent extends Model {
  int greenWeight;
  WeightUnit greenWeightUnit;
  int estimatedGreenWeight;
  WeightUnit estimatedGreenWeightUnit;
  int estimatedWeight;
  WeightUnit estimatedWeightUnit;
  int individuals;
  DateTime createdAt;
  double latitude;
  double longitude;
  String tagNumber;
  int fishingSetId;
  int speciesId;
  int disposalStateId;
  int conditionId;
  int tripId;

  FishingSetEvent({
    int id,
    this.conditionId,
    this.disposalStateId,
    this.estimatedGreenWeight,
    this.estimatedGreenWeightUnit,
    this.estimatedWeight,
    this.estimatedWeightUnit,
    this.fishingSetId,
    this.greenWeight,
    this.greenWeightUnit = WeightUnit.GRAMS,
    this.individuals,
    this.latitude,
    this.longitude,
    this.speciesId,
    this.tagNumber,
    this.tripId,
    this.createdAt,
  }) : super(id: id);

  @override
  Map<String, dynamic> toDatabaseMap() {
    return {
      'green_weight': greenWeight,
      'green_weight_unit': greenWeightUnit.toString(),
      'estimated_green_weight': estimatedGreenWeight,
      'estimated_green_weight_unit': estimatedGreenWeightUnit.toString(),
      'estimated_weight': estimatedWeight,
      'estimated_weight_unit': estimatedWeightUnit.toString(),
      'individuals': individuals,
      'created_at': createdAt.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'tag_number': tagNumber,
      'fishing_set_id': fishingSetId,
      'species_id': speciesId,
      'disposal_state_id': disposalStateId,
      'condition_id': conditionId,
      'trip_id': tripId,
    };
  }
}
//Need to ask about this....

//'FOREIGN KEY (condition_id) REFERENCES conditions (id), '
//'FOREIGN KEY (species_id) REFERENCES species (id), '
//'FOREIGN KEY (disposal_state_id) REFERENCES disposal_states (id), '
//'FOREIGN KEY (trip_id) REFERENCES trips (id) '
