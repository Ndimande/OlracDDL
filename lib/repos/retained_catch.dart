import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/retained_catch.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/species.dart';

class RetainedCatchRepo extends DatabaseRepo<RetainedCatch> {
  RetainedCatchRepo() : super(tableName: 'retained_catch', database: DatabaseProvider().database);

  @override
  Future<RetainedCatch> fromDatabaseResult(Map<String, dynamic> result) async {
    final WeightUnit greenWeightUnit = weightUnitFromString(result['green_weight_unit']);
    final Species species = await SpeciesRepo().find(result['species_id']);
    return RetainedCatch(
      id: result['id'],
      greenWeight: result['green_weight'],
      greenWeightUnit: greenWeightUnit,
      individuals: result['individuals'],
      createdAt: DateTime.parse(result['created_at']),
      location: Location(latitude: result['latitude'], longitude: result['longitude']),
      species: species,
      fishingSetID: result['fishing_set_id']
    );
  }
}
