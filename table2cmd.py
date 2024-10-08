#!/usr/bin/env python

import mysql.connector
from tabulate import tabulate

from scripts.key2table import convert_table


def run_sql_cmd(sql_table, column, value):
    config = {
        "user": "thermo_user",
        "password": "password",
        "host": "localhost",
        "database": "thermodynamics",
    }

    conn = mysql.connector.connect(**config)
    cursor = conn.cursor()
    if column is None or value is None:
        sql_cmd = f"SELECT * FROM {sql_table}"
    else: 
        sql_cmd = f"SELECT * FROM {sql_table} WHERE {column} = '{value}'"

    try:
        cursor.execute(sql_cmd)
        result = cursor.fetchall()

        # Fetch column names
        column_names = [i[0] for i in cursor.description]
        # Format the result using tabulate
        formatted_result = tabulate(result, headers=column_names, tablefmt="psql")

        print(formatted_result)
    except mysql.connector.Error as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()


def convert2table():
    table = ""
    elements = {
        "water": "water",
        "water pressure entry": "water_pressure_entry",
        "ammonia": "ammonia",
        "carbion dioxide": "carbon_diox",
        "methane": "methane",
        "compressed liquid water": "compr_liq_water",
        "saturated solid saturated vapor water": "solid_sat_vapor_water",
        "vapor water": "vapor_water",
        "nitrogen": "nitrogen",
        "methane": "methane",
        "r134a": "r134a",
        "r410a": "r410a",
    }

    available_elements = elements.keys()

    print("Available elements: ")

    for i in range(len(available_elements)):
        print(f"{i+1}. {list(available_elements)[i]}")

    element = None
    state = None
    property = None
    pressure = None

    print("\nElement? slect from the list above (1-11)")
    element = input()
    element = list(available_elements)[int(element) - 1].lower()
    element = elements.get(element)

    #Determine state, the first if statement is for the saturated water and saturated water pressure entry, as the only state they can be in is saturated
    if element == "water" or element == "water_pressure_entry" or element == "solid_sat_vapor_water":
        state = "s"
    elif element != "compr_liq_water":
        print("Saturated or superheated? (s/su)")
        state = input()

    #If the state is saturated, the user must choose between specific volume/internal energy or enthalpy/entropy
    if state == ("s"):
        print("Specific volume/Internal energy or Enthalpy/Entropy? (sv/ee)")
        property = input()

        #Change shorthand to full name
        if property == "sv":
            property = "vol_eng"
        else:
            property = "enthalpy_entropy"

    #If the state is superheated, the user must enter a pressure range, else the state is saturated
    if state == "su" or element == "compr_liq_water":
        print("Enter pressure range (kPa) (e.g. 50-100)")
        pressure = input()
        pressures = pressure.split("-")
        pressure = "pa" + pressures[0] + "_pa" + pressures[1]
    else:
        state = "sat"

    #Change shorthand to full name
    if state == "su":
        state = "superheated"

    #Column names to search by
    lookup_type = ("Look up by temperature", "Get all data from table")

    print("")

    #Print column names available to search by
    for i in range(len(lookup_type)):
        print(f"{i+1}. {lookup_type[i]}")

    #User selects column name to search by
    print(f"\nLook up name? select from the list above (1-2)")
    lookup_name = input()
    lookup_name = lookup_type[int(lookup_name) - 1]

    lookup_val = 0

    #User enters value to search by if they selected the first option
    if lookup_name == "Look up by temperature":
        print(f"Look up value for {lookup_name}?")
        lookup_name = "temperature"
        lookup_val = input()

    #Create table name in correct format
    if element == "compr_liq_water":
        table = {f"{element}_{pressure}": [f"{lookup_name}", f"{lookup_val}"]}
    elif state == "superheated":
        table = {f"{state}_{element}_{pressure}": [f"{lookup_name}", f"{lookup_val}"]}
    else:
        table = {f"{state}_{element}_{property}": [f"{lookup_name}", f"{lookup_val}"]}
    return lookup_name, table


lookup_name, table_w_look_up = convert2table()
sql_table = table_w_look_up.keys()
sql_table = list(sql_table)[0]
column = table_w_look_up[sql_table][0]
value = table_w_look_up[sql_table][1]

if lookup_name == "temperature":
    print(f"Running sql command: SELECT * FROM {sql_table} WHERE {column} = {value}...")
else:
    print(f"Running sql command: SELECT * FROM {sql_table}...")

if lookup_name == "temperature":
    run_sql_cmd(sql_table, column, value)
else:
    run_sql_cmd(sql_table, None, None)

table = convert_table(sql_table)

print(f"\nThe proper table for {sql_table} is {table}")
