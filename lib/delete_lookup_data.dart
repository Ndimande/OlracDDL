


import 'package:olracddl/models/sea_bottom_type.dart';
import 'package:olracddl/repos/catch_condition.dart';
import 'package:olracddl/repos/crew_member.dart';
import 'package:olracddl/repos/fishing_area.dart';
import 'package:olracddl/repos/port.dart';
import 'package:olracddl/repos/sea_bottom_type.dart';
import 'package:olracddl/repos/sea_condition.dart';
import 'package:olracddl/repos/skipper.dart';
import 'package:olracddl/repos/species.dart';
import 'package:olracddl/repos/vessel.dart';



Future<void> deleteSpecies() async{
  await SpeciesRepo().deleteAll(); 
}

Future<void> deletePorts() async{
  await PortRepo().deleteAll(); 
}

Future<void> deleteVessels() async{
  await VesselRepo().deleteAll(); 
}

Future<void> deleteFishingAreas() async{
  await FishingAreaRepo().deleteAll(); 
}

Future<void> deleteCrewMembers() async{
  await CrewMemberRepo().deleteAll(); 
}

Future<void> deleteSkippers() async{
  await SkipperRepo().deleteAll(); 
}

Future<void> deleteCatchConditions() async{
  await CatchConditionRepo().deleteAll(); 
}

Future<void> deleteSeaConditions() async{
  await SeaConditionRepo().deleteAll(); 
}

Future<void> deleteSeaBottomType() async{
  await SeaBottomTypeRepo().deleteAll(); 
}

