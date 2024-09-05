CREATE TABLE sat_solid_sat_vapor_water_vol_eng(
    temperature REAL NOT NULL,
    pressure REAL NOT NULL,
    sat_solid_spec_vol REAL NOT NULL,
    evaporation_spec_vol REAL NOT NULL,
    sat_vapor_spec_vol REAL NOT NULL,
    sat_solid_inter_eng REAL NOT NULL,
    evaporation_inter_eng REAL NOT NULL,
    sat_vapor_inter_eng REAL NOT NULL
);

CREATE TABLE sat_solid_sat_vapor_water_enthalpy_entropy (
    temperature REAL NOT NULL,
    pressure REAL NOT NULL,
    sat_solid_enthalpy REAL NOT NULL,
    evaporation_enthalpy REAL NOT NULL,
    sat_vapor_enthalpy REAL NOT NULL,
    sat_solid_entropy REAL NOT NULL,
    evaporation_entropy REAL NOT NULL,
    sat_vapor_entropy REAL NOT NULL

);


