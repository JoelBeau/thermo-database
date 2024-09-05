import pandas as pd
import sys


def read_file(file):
    df = {}
    with open(file, "r") as f:
        for line in f:
            line = line.strip()
            if line.startswith("Table"):
                current_table = line
                df[current_table] = []
            else:
                df[current_table].append(line)
    return pd.DataFrame.from_dict(df, orient="index").transpose()


def find_proper_table(df, key):
    for table in df:
        if key in df[table].values:
            return table
    return None

def convert_table(table_used):
    file = "../data/TableKey.txt"
    df = read_file(file)

    sql_table = table_used

    table = find_proper_table(df, sql_table)
    
    return table
