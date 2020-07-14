import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/disposal_state.dart';
import 'package:olracddl/models/species.dart';

class FishingSetEvent extends Model {
  /// Green weight and unit
  int greenWeight;
  WeightUnit greenWeightUnit;

  /// Estimated green weight and unit
  int estimatedGreenWeight;
  WeightUnit estimatedGreenWeightUnit;

  /// Estimated weight and unit
  int estimatedWeight;
  WeightUnit estimatedWeightUnit;

  /// The time the event was created.
  DateTime createdAt;

  /// Latitude and Longitude
  double latitude;
  double longitude;

  /// Number of animals
  int individuals;

  String tagNumber;

  /// The parent fishing set ID
  int fishingSetId;

  /// The species that the event involves
  Species species;

  /// The disposal state.
  /// null if no disposal.
  DisposalState disposalState;

  /// Catch condition
  CatchCondition catchCondition;

  FishingSetEvent({
    int id,
    this.catchCondition,
    this.disposalState,
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
    this.species,
    this.tagNumber,
    this.createdAt,
  }) : super(id: id);

  @override
  Future<Map<String, dynamic>> toDatabaseMap() async {
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
      'species_id': species.id,
      'disposal_state_id': disposalState.id,
      'condition_id': catchCondition.id,
    };
  }
}
