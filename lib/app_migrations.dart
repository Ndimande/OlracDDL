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
        'minimum_hook_size INTEGER, '
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
    (1, "assets/images/b1.png", "00-02 Calm/Still"),
    (2, "assets/images/b2.png", "03-04 Choppy"),
    (3, "assets/images/b3.png", "05-07 Rough"),
    (4, "assets/images/b4.png", "08-10 Stormy"),
    (5, "assets/images/b5.png", "11-12 Extreme")
  '''),
  Migration(name: 'populate_cloud_types', sql: '''
    INSERT INTO cloud_types (id, image_string,name) VALUES
    (1, "assets/images/ct1.jpeg", "Altocumulus"),
    (2, "assets/images/ct2.jpeg", "Altostratus"),
    (3, "assets/images/ct3.jpeg", "Cirrocumulus"),
    (4, "assets/images/ct4.jpeg", "Cirrostratus"),
    (5, "assets/images/ct5.jpeg", "Cirrus"),
    (6, "assets/images/ct6.jpeg", "Cumulunimbus"),
    (7, "assets/images/ct7.jpeg", "Cumulus"),
    (8, "assets/images/ct8.jpeg", "Fog"),
    (9, "assets/images/ct9.jpeg", "Lenticular"),
    (10, "assets/images/ct10.jpeg", "Mammatus"),
    (11, "assets/images/ct11.jpeg", "Nimbostratus"),
    (12, "assets/images/ct12.jpeg", "Stratocumulus"),
    (13, "assets/images/ct13.jpeg", "Stratus")
  '''),
  Migration(name: 'populate_cloud_covers', sql: '''
    INSERT INTO cloud_covers (id, image_string,name) VALUES
    (1, "assets/images/cc1.jpeg", "0/8"),
    (2, "assets/images/cc2.jpeg", "1/8"),
    (3, "assets/images/cc3.jpeg", "2/8"),
    (4, "assets/images/cc4.jpeg", "3/8"),
    (5, "assets/images/cc5.jpeg", "4/8"),
    (6, "assets/images/cc6.jpeg", "5/8"),
    (7, "assets/images/cc7.jpeg", "6/8"),
    (8, "assets/images/cc8.jpeg", "7/8"),
    (9, "assets/images/cc9.jpeg", "8/8")
  '''),
  Migration(name: 'populate_moon_phases', sql: '''
    INSERT INTO moon_phases (id, image_string,name) VALUES
    (1, "assets/images/mp1.jpeg", "New moon"),
    (2, "assets/images/mp2.jpeg", "Waxing crescent"),
    (3, "assets/images/mp3.jpeg", "First quarter"),
    (4, "assets/images/mp4.jpeg", "Waxing gibbous"),
    (5, "assets/images/mp5.jpeg", "Full moon"),
    (6, "assets/images/mp6.jpeg", "Waning gibbous"),
    (7, "assets/images/mp7.jpeg", "Last quarter"),
    (8, "assets/images/mp8.jpeg", "Waning crescent")
  '''),
  Migration(name: 'populate_ports', sql: '''
    INSERT INTO ports (id, name) VALUES
    (1, "Ponta Delgada"),
    (2, "Madalena"),
    (3, "Angra do Heroísmo"),
    (4, "Velas")
  '''),
  Migration(name: 'populate_skippers', sql: '''
    INSERT INTO skippers (id, name) VALUES
    (1, "José Mourinho"),
    (2, "Cristiano Ronaldo")
  '''),
  Migration(name: 'populate_countries', sql: '''
    INSERT INTO countries (id, name) VALUES
    (1, "Portugal"),
    (2, "United Kingdom")
  '''),
  Migration(name: 'populate_vessels', sql: '''
    INSERT INTO vessels (id, name, vessel_id) VALUES
    (1, "Pier Pressure", "00123456"),
    (2, "Knot Shore", "00987654")
  '''),
];
