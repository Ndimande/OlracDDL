import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/fishing_set_event.dart';
import 'package:olracddl/providers/database.dart';

class FishingSetEventRepo extends DatabaseRepo<FishingSetEvent> {
  FishingSetEventRepo() : super(tableName: 'fishing_set_events', database: DatabaseProvider().database);

  @override
  FishingSetEvent fromDatabaseResult(Map<String, dynamic> result) {
    final String greenWeightUnitResult = result['green_weight_unit'];
    WeightUnit greenWeightUnit;
    if (greenWeightUnitResult == WeightUnit.GRAMS.toString()) {
      greenWeightUnit = WeightUnit.GRAMS;
    } else if (greenWeightUnitResult == WeightUnit.OUNCES.toString()) {
      greenWeightUnit = WeightUnit.OUNCES;
    }

    final String estimatedWeightUnitResult = result['weight_unit'];
    WeightUnit estimatedWeightUnit;
    if (estimatedWeightUnitResult == WeightUnit.GRAMS.toString()) {
      estimatedWeightUnit = WeightUnit.GRAMS;
    } else if (estimatedWeightUnitResult == WeightUnit.OUNCES.toString()) {
      estimatedWeightUnit = WeightUnit.OUNCES;
    }

    final String estimatedGreenWeightUnitResult = result['green_weight_unit'];
    WeightUnit estimatedGreenWeightUnit;
    if (estimatedGreenWeightUnitResult == WeightUnit.GRAMS.toString()) {
      estimatedGreenWeightUnit = WeightUnit.GRAMS;
    } else if (estimatedGreenWeightUnitResult == WeightUnit.OUNCES.toString()) {
      estimatedGreenWeightUnit = WeightUnit.OUNCES;
    }

    return FishingSetEvent(
      id: result['id'],
      greenWeight: result['green_weight'],
      greenWeightUnit: greenWeightUnit,
      estimatedGreenWeight: result['estimated_green_weight'],
      estimatedGreenWeightUnit: estimatedGreenWeightUnit,
      estimatedWeight: result['estimated_weight'],
      estimatedWeightUnit: estimatedWeightUnit,
      individuals: result['individuals'],
      latitude: result['latitude'],
      longitude: result['longitude'],
      tagNumber: result['tag_number'],
      fishingSetId: result['fishing_set_id'],
      speciesId: result['species_id'],
      disposalStateId: result['disposal_state_id'],
      conditionId: result['condition_id'],
      tripId: result['trip_id'],
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
