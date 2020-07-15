import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/catch_condition.dart';
import 'package:olracddl/models/disposal_state.dart';
import 'package:olracddl/models/fishing_set_event.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/disposal_state.dart';
import 'package:olracddl/repos/species.dart';

class FishingSetEventRepo extends DatabaseRepo<FishingSetEvent> {
  FishingSetEventRepo() : super(tableName: 'fishing_set_events', database: DatabaseProvider().database);

  @override
  Future<FishingSetEvent> fromDatabaseResult(Map<String, dynamic> result) async {
    final WeightUnit greenWeightUnit = weightUnitFromString(result['green_weight_unit']);
    final WeightUnit estimatedWeightUnit = weightUnitFromString(result['weight_unit']);
    final WeightUnit estimatedGreenWeightUnit = weightUnitFromString(result['green_weight_unit']);

    final Species species = await SpeciesRepo().find(result['species_id']);
    final DisposalState disposalState = await DisposalStateRepo().find(result['disposal_state_id']);
    final CatchCondition catchCondition = await CatchConditionRepo().find(result['condition_id']);

    return FishingSetEvent(
      id: result['id'],
      // Measurements
      greenWeight: result['green_weight'],
      greenWeightUnit: greenWeightUnit,
      estimatedGreenWeight: result['estimated_green_weight'],
      estimatedGreenWeightUnit: estimatedGreenWeightUnit,
      estimatedWeight: result['estimated_weight'],
      estimatedWeightUnit: estimatedWeightUnit,
      // time / location
      location: Location(latitude: result['latitude'], longitude: result['longitude']),
      createdAt: DateTime.parse(result['created_at']),
      individuals: result['individuals'],
      //other
      tagNumber: result['tag_number'],
      // related data
      fishingSetId: result['fishing_set_id'],
      species: species,
      disposalState: disposalState,
      catchCondition: catchCondition,
    );
  }
}
