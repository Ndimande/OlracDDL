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
        'name TEXT UNIQUE NOT NULL '
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
  Migration(
    name: 'create_fishing_set_events',
    sql: 'CREATE TABLE fishing_set_events ( '
        'id INTEGER PRIMARY KEY, '
        // Measurements
        'green_weight INTEGER, '
        'green_weight_unit TEXT, '
        'estimated_green_weight INTEGER, '
        'estimated_green_weight_unit TEXT, '
        'estimated_weight INTEGER, '
        'estimated_weight_unit TEXT, '
        // time / location
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'latitude REAL, '
        'longitude REAL '
        // other
        'individuals INTEGER, '
        'tag_number TEXT, '
        // Foreign keys
        'fishing_set_id INTEGER, '
        'species_id INTEGER, '
        'disposal_state_id INTEGER, '
        'condition_id INTEGER,'
        'FOREIGN KEY (condition_id) REFERENCES conditions (id), '
        'FOREIGN KEY (species_id) REFERENCES species (id), '
        'FOREIGN KEY (disposal_state_id) REFERENCES disposal_states (id) '
        ')',
  ),
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
];
