import 'package:migrator/migrator.dart';

const List<Migration> appMigrations = <Migration>[
  Migration(
    name: 'create_json',
    sql: 'CREATE TABLE json ( '
        'key TEXT PRIMARY KEY, '
        'json TEXT NOT NULL, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_ports',
    sql: 'CREATE TABLE ports ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_vessels',
    sql: 'CREATE TABLE vessels ( '
        'id INTEGER PRIMARY KEY, '
        'vessel_id TEXT, ' // NOT A FK
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_fishing_areas',
    sql: 'CREATE TABLE fishing_areas ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_sea_bottom_types',
    sql: 'CREATE TABLE sea_bottom_types ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_sea_conditions',
    sql: 'CREATE TABLE sea_conditions ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'image_string TEXT NOT NULL, '
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_cloud_types',
    sql: 'CREATE TABLE cloud_types ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'image_string TEXT NOT NULL, '
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_cloud_covers',
    sql: 'CREATE TABLE cloud_covers ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'image_string TEXT NOT NULL, '
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_moon_phases',
    sql: 'CREATE TABLE moon_phases ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'image_string TEXT NOT NULL, '
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_disposal_states',
    sql: 'CREATE TABLE disposal_states ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    // refers to marine life condition
    name: 'create_conditions',
    sql: 'CREATE TABLE conditions ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_species',
    sql: 'CREATE TABLE species ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'common_name TEXT UNIQUE, '
        'scientific_name TEXT UNIQUE '
        ')',
  ),
  Migration(
    name: 'create_fishing_methods',
    sql: 'CREATE TABLE fishing_methods ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL, '
        'abbreviation TEXT UNIQUE NOT NULL, '
        'svgPath TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_countries',
    sql: 'CREATE TABLE countries ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_skippers',
    sql: 'CREATE TABLE skippers ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_crew_members',
    sql: 'CREATE TABLE crew_members ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT UNIQUE NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_trips',
    sql: 'CREATE TABLE trips ( '
        //ids
        'id INTEGER PRIMARY KEY, '
        'uuid TEXT UNIQUE NOT NULL, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        // trip start
        'started_at TIMESTAMP, '
        'start_latitude REAL, '
        'start_longitude REAL, '
        // trip end
        'ended_at TIMESTAMP, '
        'end_latitude REAL, '
        'end_longitude REAL, '
        // other
        'crew_members_json TEXT, '
        'notes TEXT, '
        'uploaded_at TIMESTAMP, '
        // Foreign keys
        'port_id INTEGER, '
        'vessel_id INTEGER, '
        'skipper_id INTEGER, '
        'FOREIGN KEY (vessel_id) REFERENCES vessels (id), '
        'FOREIGN KEY (skipper_id) REFERENCES skipper (id), '
        'FOREIGN KEY (port_id) REFERENCES ports (id) '
        ')',
  ),
  Migration(
    name: 'create_trip_has_crew_members',
    sql: 'CREATE TABLE trip_has_crew_members ( '
        'trip_id INTEGER NOT NULL, '
        'crew_member_id INTEGER NOT NULL, '
        'FOREIGN KEY (crew_member_id) REFERENCES crew_members (id), '
        'FOREIGN KEY (trip_id) REFERENCES trips (id) '
        ')',
  ),
  Migration(
    name: 'create_fishing_sets',
    sql: 'CREATE TABLE fishing_sets ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        //  time / location
        'started_at TIMESTAMP, '
        'start_latitude REAL, '
        'start_longitude REAL, '
        'ended_at TIMESTAMP, '
        'end_latitude REAL, '
        'end_longitude REAL, '
        // Other
        'sea_bottom_depth INTEGER, '
        'sea_bottom_depth_unit TEXT, '
        'minimum_hook_size TEXT, '
        'hooks INTEGER, '
        'traps INTEGER, '
        'lines_used INTEGER, '
        'notes TEXT, '
        // Foreign keys
        'trip_id INTEGER, '
        'sea_bottom_type_id INTEGER, '
        'target_species_id INTEGER, '
        'moon_phase_id INTEGER, '
        'cloud_type_id INTEGER, '
        'cloud_cover_id INTEGER, '
        'sea_condition_id INTEGER, '
        'fishing_method_id INTEGER, '
        'FOREIGN KEY (sea_bottom_type_id) REFERENCES sea_bottom_types (id), '
        'FOREIGN KEY (target_species_id) REFERENCES species (id), '
        'FOREIGN KEY (moon_phase_id) REFERENCES moon_phases (id), '
        'FOREIGN KEY (cloud_type_id) REFERENCES cloud_types (id), '
        'FOREIGN KEY (cloud_cover_id) REFERENCES cloud_covers (id), '
        'FOREIGN KEY (sea_condition_id) REFERENCES sea_conditions (id), '
        'FOREIGN KEY (fishing_method_id) REFERENCES fishing_methods (id), '
        'FOREIGN KEY (trip_id) REFERENCES trips (id) '
        ')',
  ),
  Migration(name: 'create_retained_catch', sql: '''
    CREATE TABLE retained_catch (
    id INTEGER PRIMARY KEY,
    green_weight INTEGER, 
    green_weight_unit TEXT, 
    individuals INTEGER,
    latitude REAL,
    longitude REAL, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, 
    species_id INTEGER,
    fishing_set_id INTEGER, 
    FOREIGN KEY (fishing_set_id) REFERENCES fishing_sets (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
    )
    '''),
  Migration(name: 'create_disposals', sql: '''
    CREATE TABLE disposals (
    id INTEGER PRIMARY KEY,
    estimated_green_weight INTEGER, 
    estimated_green_weight_unit TEXT, 
    individuals INTEGER,
    latitude REAL,
    longitude REAL, 
    species_id INTEGER,
    disposal_state_id INTEGER,
    fishing_set_id INTEGER, 
    FOREIGN KEY (fishing_set_id) REFERENCES fishing_sets (id),
    FOREIGN KEY (disposal_state_id) REFERENCES disposal_states (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
    )
    '''),
  Migration(name: 'create_marine_life', sql: '''
    CREATE TABLE marine_life (
    id INTEGER PRIMARY KEY,
    estimated_weight INTEGER, 
    estimated_weight_unit TEXT, 
    individuals INTEGER,
    latitude REAL,
    longitude REAL, 
    tagNumber TEXT,
    species_id INTEGER,
    fishing_set_id INTEGER, 
    condition_id INTEGER,
    FOREIGN KEY (condition_id) REFERENCES conditions (id),
    FOREIGN KEY (fishing_set_id) REFERENCES fishing_sets (id),
    FOREIGN KEY (species_id) REFERENCES species (id)
    )
    '''),
  Migration(name: 'populate_sea_conditions', sql: '''
    INSERT INTO sea_conditions (id, image_string,name) VALUES
    (1, 'assets/images/b1.png', '00-02 Calm/Still'),
    (2, 'assets/images/b2.png', '03-04 Choppy'),
    (3, 'assets/images/b3.png', '05-07 Rough'),
    (4, 'assets/images/b4.png', '08-10 Stormy'),
    (5, 'assets/images/b5.png', '11-12 Extreme')
  '''),
  Migration(name: 'populate_cloud_types', sql: '''
    INSERT INTO cloud_types (id, image_string,name) VALUES
    (1, 'assets/images/ct1.jpeg', 'Altocumulus'),
    (2, 'assets/images/ct2.jpeg', 'Altostratus'),
    (3, 'assets/images/ct3.jpeg', 'Cirrocumulus'),
    (4, 'assets/images/ct4.jpeg', 'Cirrostratus'),
    (5, 'assets/images/ct5.jpeg', 'Cirrus'),
    (6, 'assets/images/ct6.jpeg', 'Cumulunimbus'),
    (7, 'assets/images/ct7.jpeg', 'Cumulus'),
    (8, 'assets/images/ct8.jpeg', 'Fog'),
    (9, 'assets/images/ct9.jpeg', 'Lenticular'),
    (10, 'assets/images/ct10.jpeg', 'Mammatus'),
    (11, 'assets/images/ct11.jpeg', 'Nimbostratus'),
    (12, 'assets/images/ct12.jpeg', 'Stratocumulus'),
    (13, 'assets/images/ct13.jpeg', 'Stratus')
  '''),
  Migration(name: 'populate_cloud_covers', sql: '''
    INSERT INTO cloud_covers (id, image_string,name) VALUES
    (1, 'assets/images/cc1.jpeg', '0/8'),
    (2, 'assets/images/cc2.jpeg', '1/8'),
    (3, 'assets/images/cc3.jpeg', '2/8'),
    (4, 'assets/images/cc4.jpeg', '3/8'),
    (5, 'assets/images/cc5.jpeg', '4/8'),
    (6, 'assets/images/cc6.jpeg', '5/8'),
    (7, 'assets/images/cc7.jpeg', '6/8'),
    (8, 'assets/images/cc8.jpeg', '7/8'),
    (9, 'assets/images/cc9.jpeg', '8/8')
  '''),
  Migration(name: 'populate_moon_phases', sql: '''
    INSERT INTO moon_phases (id, image_string,name) VALUES
    (1, 'assets/images/mp1.jpeg', 'New moon'),
    (2, 'assets/images/mp2.jpeg', 'Waxing crescent'),
    (3, 'assets/images/mp3.jpeg', 'First quarter'),
    (4, 'assets/images/mp4.jpeg', 'Waxing gibbous'),
    (5, 'assets/images/mp5.jpeg', 'Full moon'),
    (6, 'assets/images/mp6.jpeg', 'Waning gibbous'),
    (7, 'assets/images/mp7.jpeg', 'Last quarter'),
    (8, 'assets/images/mp8.jpeg', 'Waning crescent')
  '''),
  Migration(name: 'populate_ports', sql: '''
    INSERT INTO ports (id, name) VALUES
    (1, 'Corvo'),
    (2, 'Faial'),
    (3, 'Flores'),
    (4, 'Graciosa'),
    (5, 'Pico'),
    (6, 'Santa Maria'),
    (7, 'Sao Jorge'),
    (8, 'Sao Miguel'),
    (9, 'Terceira')
  '''),
  Migration(name: 'populate_skippers', sql: '''
    INSERT INTO skippers (id, name) VALUES
    (1, 'José Mourinho'),
    (2, 'Cristiano Ronaldo')
  '''),
  Migration(name: 'populate_countries', sql: '''
    INSERT INTO countries (id, name) VALUES
    (1, 'Portugal'),
    (2, 'United Kingdom')
  '''),
  Migration(name: 'populate_vessels', sql: '''
    INSERT INTO vessels (id, name, vessel_id) VALUES
    (1, 'Adriano Luz', 'SG-253-L'),
    (2, 'Alexju', 'SG-259-L'),
    (3, 'Ana Regina', 'SG-272-L'),
    (4, 'Ermelindo', 'SG-243-L'),
    (5, 'Golfim', 'SG-265-C'),
    (6, 'Lagosta', 'SG-249-L'),
    (7, 'Leonardo De Jesus', 'SG-256-L'),
    (8, 'Luana', 'SG-261-L'),
    (9, 'Mestre Melo', 'SG-276-C'),
    (10, 'Morrao Novo', 'SG-230-L'),
    (11, 'Natercia', 'SG-267-L'),
    (12, 'Raio Verde', 'SG-271-L'),
    (13, 'Ricardo Nuno', 'SG-240-L'),
    (14, 'Santa Idalina', 'SG-242-L'),
    (15, 'Uniao', 'SG-10-L')
  '''),
  Migration(
    name: 'populate_sea_bottom_types',
    sql: '''
    INSERT INTO sea_bottom_types (id, name) VALUES
    (1, 'Sand'),
    (2, 'Mud'),
    (3, 'Rock'),
    (4, 'Gravel')
  ''',
  ),
  Migration(
    name: 'populate_species',
    sql: '''
    INSERT INTO species (id, common_name, scientific_name) VALUES
    (1,'Albacore','Thunnus alalunga'),
    (2,'Alfonsino','Beryx decadactylus'),
    (3,'Arrowhead dogfish','Deania profundorum'),
    (4,'Atlantic bonito','Sarda sarda'),
    (5,'Axillary seabream','Pagellus acarne'),
    (6,'Azorean barnacle','Megabalanus azoricus'),
    (7,'Ballan wrasse ','Labrus bergylta'),
    (8,'Bigeye tuna','Thunnus obesus'),
    (9,'Black cardinal fish','Epigonus telescopus'),
    (10,'Black scabbardfish (Q)','Aphanopus carbo'),
    (11,'Blackbelly rosefish','Helicolenus dactylopterus'),
    (12,'Blacktail comber','Serranus atricauda'),
    (13,'Blue jack mackerel (Bait)','Trachurus picturatus'),
    (14,'Blue ling / Spanish ling','Molva macrophtalma'),
    (15,'Blue shark','Prionace glauca'),
    (16,'Bluefish','Pomatomus saltatrix'),
    (17,'Bogue','Boops boops'),
    (18,'Brown moray','Gymnothorax unicolor'),
    (19,'Chub mackerel (bait)','Scomber colias'),
    (20,'Common dolphin fish','Coryphaena hippurus'),
    (21,'Common mora','Mora moro'),
    (22,'Common octopus','Octopus vulgaris'),
    (23,'Common seabream/Red Porgy ','Pagrus pagrus'),
    (24,'Common spiny lobster','Palinurus elephas'),
    (25,'Common two-banded seabream','Diplodus vulgaris'),
    (26,'Deep-Sea red crab','Chaceon affinis'),
    (27,'Dusky grouper','Epinephelus marginatus'),
    (28,'Emerald wrasse ','Centrolabrus trutta'),
    (29,'Escolar','Lepidocybium flavobrunneum'),
    (30,'European barracuda','Sphyraena viridensis'),
    (31,'European conger','Conger conger'),
    (32,'Forkbeard','Phycis phycis'),
    (33,'Greater amberjack','Seriola dumerili'),
    (34,'Greater forkbeard','Phycis blennoides'),
    (35,'Grey triggerfish','Balistes capriscus'),
    (36,'Imperial blackfish','Schedophilus ovalis'),
    (37,'Intermediat scabbardfish','Aphanopus intermedius'),
    (38,'John dory ','Zeus faber '),
    (39,'Kitefin shark','Dalatias licha'),
    (40,'Limpet','Patella candei'),
    (41,'Marbled rock crab','Pachygrapsus marmoratus'),
    (42,'Mediterranean locust lobster','Scyllarides latus'),
    (43,'Mediterranean moray','Muraena helena'),
    (44,'Offshore rockfish','Pontinus kuhlii'),
    (45,'Parrotfish','Sparisoma cretense '),
    (46,'Pompano','Trachinotus ovatus'),
    (47,'Rainbow wrasse','Coris julis'),
    (48,'Red gurnard','Aspitrigla cuculus'),
    (49,'Red mullet','Mullus surmuletus'),
    (50,'Red Scorpionfish','Scorpaena scrofa'),
    (51,'Red sea-bream / Black spot seabream','Pagellus bogaraveo'),
    (52,'Rough limpet or China limpet','Patella aspera'),
    (53,'Salema/Saupe','Sarpa salpa'),
    (54,'Sardine / European pilchard','Sardina pilchardus'),
    (55,'Sargo or White Sea bream','Diplodus sargus'),
    (56,'Scale-rayed  wrasse/ Cuckoo wrasse','Labrus mixtus'),
    (57,'Shortfin mako','Isurus oxyrinchus'),
    (58,'Silver scabbardfish','Lepidopus caudatus'),
    (59,'Skipjack tuna ','Katsuwonus pelamis'),
    (60,'Smooth hammerhead','Sphyrna zygaena'),
    (61,'Spanish agar/Agar-agar','Pterocladiella capillacea'),
    (62,'Spinous spider crab','Maja squinado'),
    (63,'Splendid alfonsino','Beryx splendens'),
    (64,'Swordfish','Xiphias gladius'),
    (65,'thick-lipped grey mullet','Chelon labrosus'),
    (66,'Thornback ray','Raja clavata'),
    (67,'Toothed rock crab','Cancer bellianus'),
    (68,'Tope shark','Galeorhinus galeus'),
    (69,'Veyned squid','Loligo forbesi'),
    (70,'White or silver trevally','Pseudocaranx dentex'),
    (71,'Wreckfish','Polyprion americanus'),
    (72,'Yellow/ Bermuda sea chub','Kyphosus spp'),
    (73,'Yellowfin tuna','Thunnus albacares'),
    (74,'Shrimps','Shrimps')
  ''',
  ),
  Migration(
    name: 'populate_conditions',
    sql: '''
    INSERT INTO conditions (id, name) VALUES
    (1, 'Alive'),
    (2, 'Alive and sluggish'),
    (3, 'Alive and vigorous'),
    (4, 'Dead'),
    (5, 'Dead and damaged'),
    (6, 'Dead and flexible'),
    (7, 'Dead and in rigor'),
    (8, 'Injured'),
    (9, 'Unknown')
  ''',
  ),
  Migration(
    name: 'populate_fishing_areas',
    sql: '''
    INSERT INTO fishing_areas (id, name) VALUES
    (1,'14B6'),
    (2,'14B7'),
    (3,'14B8'),
    (4,'14B9'),
    (5,'14C0'),
    (6,'14C1'),
    (7,'13B5'),
    (8,'13B6'),
    (9,'13B7'),
    (10,'13B8'),
    (11,'13B9'),
    (12,'13C0'),
    (13,'13C1'),
    (14,'13C2'),
    (15,'13C3'),
    (16,'13C4'),
    (17,'12B5'),
    (18,'12B6'),
    (19,'12B7'),
    (20,'12B8'),
    (21,'12B9'),
    (22,'12C0'),
    (23,'12C1'),
    (24,'12C2'),
    (25,'12C3'),
    (26,'12C4'),
    (27,'12C5'),
    (28,'11B4'),
    (29,'11B5'),
    (30,'11B6'),
    (31,'11B7'),
    (32,'11B8'),
    (33,'11B9'),
    (34,'11C0'),
    (35,'11C1'),
    (36,'11C2'),
    (37,'11C3'),
    (38,'11C4'),
    (39,'11C5'),
    (40,'11C6'),
    (41,'10B4'),
    (42,'10B5'),
    (43,'10B6'),
    (44,'10B7'),
    (45,'10B8'),
    (46,'10B9'),
    (47,'10C0'),
    (48,'10C1'),
    (49,'10C2'),
    (50,'10C3'),
    (51,'10C4'),
    (52,'10C5'),
    (53,'10C6'),
    (54,'10C7'),
    (55,'09B4'),
    (56,'09B5'),
    (57,'09B6'),
    (58,'09B7'),
    (59,'09B8'),
    (60,'09B9'),
    (61,'09C0'),
    (62,'09C1'),
    (63,'09C2'),
    (64,'09C3'),
    (65,'09C4'),
    (66,'09C5'),
    (67,'09C6'),
    (68,'09C7'),
    (69,'09C8'),
    (70,'08B4'),
    (71,'08B5'),
    (72,'08B6'),
    (73,'08B7'),
    (74,'08B8'),
    (75,'08B9'),
    (76,'08C0'),
    (77,'08C1'),
    (78,'08C2'),
    (79,'08C3'),
    (80,'08C4'),
    (81,'08C5'),
    (82,'08C6'),
    (83,'08C7'),
    (84,'08C8'),
    (85,'07B4'),
    (86,'07B5'),
    (87,'07B6'),
    (88,'07B7'),
    (89,'07B8'),
    (90,'07B9'),
    (91,'07C0'),
    (92,'07C1'),
    (93,'07C2'),
    (94,'07C3'),
    (95,'07C4'),
    (96,'07C5'),
    (97,'07C6'),
    (98,'07C7'),
    (99,'07C8'),
    (100,'06B4'),
    (101,'06B5'),
    (102,'06B6'),
    (103,'06B7'),
    (104,'06B8'),
    (105,'06B9'),
    (106,'06C0'),
    (107,'06C1'),
    (108,'06C2'),
    (109,'06C3'),
    (110,'06C4'),
    (111,'06C5'),
    (112,'06C6'),
    (113,'06C7'),
    (114,'06C8'),
    (115,'06C9'),
    (116,'05B4'),
    (117,'05B5'),
    (118,'05B6'),
    (119,'05B7'),
    (120,'05B8'),
    (121,'05B9'),
    (122,'05C0'),
    (123,'05C1'),
    (124,'05C2'),
    (125,'05C3'),
    (126,'05C4'),
    (127,'05C5'),
    (128,'05C6'),
    (129,'05C7'),
    (130,'05C8'),
    (131,'05C9'),
    (132,'04B4'),
    (133,'04B5'),
    (134,'04B6'),
    (135,'04B7'),
    (136,'04B8'),
    (137,'04B9'),
    (138,'04C0'),
    (139,'04C1'),
    (140,'04C2'),
    (141,'04C3'),
    (142,'04C4'),
    (143,'04C5'),
    (144,'04C6'),
    (145,'04C7'),
    (146,'04C8'),
    (147,'04C9'),
    (148,'03B5'),
    (149,'03B6'),
    (150,'03B7'),
    (151,'03B8'),
    (152,'03B9'),
    (153,'03C0'),
    (154,'03C1'),
    (155,'03C2'),
    (156,'03C3'),
    (157,'03C4'),
    (158,'03C5'),
    (159,'03C6'),
    (160,'03C7'),
    (161,'03C8'),
    (162,'03C9'),
    (163,'02B5'),
    (164,'02B6'),
    (165,'02B7'),
    (166,'02B8'),
    (167,'02B0'),
    (168,'02C0'),
    (169,'02C1'),
    (170,'02C2'),
    (171,'02C3'),
    (172,'02C4'),
    (173,'02C5'),
    (174,'02C6'),
    (175,'02C7'),
    (176,'02C8'),
    (177,'02C9'),
    (178,'01B6'),
    (179,'01B7'),
    (180,'01B8'),
    (181,'01B9'),
    (182,'01C0'),
    (183,'01C1'),
    (184,'01C2'),
    (185,'01C3'),
    (186,'01C4'),
    (187,'01C5'),
    (188,'01C6'),
    (189,'01C7'),
    (190,'01C8'),
    (191,'01C9')
  ''',
  ),
  Migration(
    name: 'populate_fishing_methods',
    sql: '''
    INSERT INTO fishing_methods (id, name, svgPath, abbreviation) VALUES
    (1, "Beach Seine", "assets/icons/fishing_methods/Oltrace_Beach_Seine.svg", "SB"),
    (2, "Boat Seine", "assets/icons/fishing_methods/Oltrace_Purse_Seine.svg", "SV"),
    (3, "Beam Trawl", "assets/icons/fishing_methods/Oltrace_Beam_Trawl.svg", "TBB"),
    (4, "Otter Trawl", "assets/icons/fishing_methods/Oltrace_Otter_Trawl.svg", "OTB"),
    (5, "Gillnets Anchored", "assets/icons/fishing_methods/Oltrace_Set_Gillnet.svg", "GNS"),
    (6, "Drift Gillnet", "assets/icons/fishing_methods/Oltrace_Drift_Gillnet.svg", "GND"),
    (7, "Handline", "assets/icons/fishing_methods/handline.svg", "HL"),
    (8, "Drifting Longline", "assets/icons/fishing_methods/Oltrace_Drift_Longline.svg", "LLD")
  ''',
  ),
  Migration(
    name: 'populate_crew_members',
    sql: '''
    INSERT INTO crew_members (id, name) VALUES
    (1, 'Crew Member 1'),
    (2, 'Crew Member 2')
  ''',
  ),
];
