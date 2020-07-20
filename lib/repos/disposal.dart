import 'package:database_repo/database_repo.dart';
import 'package:olrac_utils/olrac_utils.dart';
import 'package:olracddl/models/crew_member.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/disposal.dart';
import 'package:olracddl/models/species.dart';
import 'package:olracddl/providers/database.dart';
import 'package:olracddl/repos/species.dart';

class DisposalRepo extends DatabaseRepo<Disposal> {
  DisposalRepo() : super(tableName: 'disposals', database: DatabaseProvider().database);

  @override
  Future<Disposal> fromDatabaseResult(Map<String, dynamic> result) async {
    final Species species = await SpeciesRepo().find(result['species_id']);
    return Disposal(
      id: result['id'],
      estimatedGreenWeight: result['estimated_green_weight'],
      estimatedGreenWeightUnit: result['estimated_green_weight_unit'],
      individuals: result['individuals'],
      location: Location(latitude: result['latitude'], longitude: result['longitude']),
      species: species,
      createdAt: DateTime.parse(result['created_at']),
    );
  }
}
