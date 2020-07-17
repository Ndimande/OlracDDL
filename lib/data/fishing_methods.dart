import 'package:olracddl/models/fishing_method.dart';

List<FishingMethod> defaultFishingMethods = <FishingMethod>[
  FishingMethod(
    id: 1,
    name: 'Beach Seine',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Beach_Seine.svg',
    abbreviation: 'SB',
    createdAt: DateTime.now(),
  ),
  FishingMethod(
    id: 2,
    name: 'Boat Seine',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Purse_Seine.svg',
    abbreviation: 'SV',
    createdAt: DateTime.now(),
  ),
  FishingMethod(
    id: 3,
    name: 'Beam Trawl',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Beam_Trawl.svg',
    abbreviation: 'TBB',
    createdAt: DateTime.now(),
  ),
  FishingMethod(
    id: 4,
    name: 'Otter Trawl',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Otter_Trawl.svg',
    abbreviation: 'OTB',
    createdAt: DateTime.now(),
  ),
  FishingMethod(
    id: 5,
    name: 'Gillnets Anchored',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Set_Gillnet.svg',
    abbreviation: 'GNS',
    createdAt: DateTime.now(),
  ),
  FishingMethod(
    id: 6,
    name: 'Drift Gillnet',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Drift_Gillnet.svg',
    abbreviation: 'GND',
    createdAt: DateTime.now(),
  ),
//  FishingMethod(
//    id: 7,
//    name: 'Bottom Longline',
//    svgPath: 'assets/icons/fishing_methods/Oltrace_Set_Longline.svg',
//    abbreviation: 'LLS',
//  ),
  FishingMethod(
    id: 7,
    name: 'Handline',
    svgPath: 'assets/icons/fishing_methods/handline.svg',
    abbreviation: 'HL',
    createdAt: DateTime.now(),
  ),
  FishingMethod(
    id: 8,
    name: 'Drifting Longline',
    svgPath: 'assets/icons/fishing_methods/Oltrace_Drift_Longline.svg',
    abbreviation: 'LLD',
    createdAt: DateTime.now(),
  ),

];
