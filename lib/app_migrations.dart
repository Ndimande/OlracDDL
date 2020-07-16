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
        'vessel_id INTEGER, '
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
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_cloud_types',
    sql: 'CREATE TABLE cloud_types ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_cloud_covers',
    sql: 'CREATE TABLE cloud_covers ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
        'name TEXT NOT NULL '
        ')',
  ),
  Migration(
    name: 'create_moon_phases',
    sql: 'CREATE TABLE moon_phases ( '
        'id INTEGER PRIMARY KEY, '
        'created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL, '
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
];
