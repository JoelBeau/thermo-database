#!/bin/bash

CURRENT_DIR=$(pwd)
DAT_DIR=$CURRENT_DIR/../data

cd /var/lib/mysql-files
cp -r $DAT_DIR .

# Create the database if it doesn't exist
DB_NAME="test"

cd $CURRENT_DIR

sudo mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Function to execute SQL scripts
execute_sql_script() {
    local script_path=$1
    sudo mysql $DB_NAME <$script_path
}

dont_run=("create_thermo_database.sh" "thermodynamics.db" "table2cmd.py" "key2table.py" "install_depend.sh")

for i in $(find ./ -type f); do
    filename=$(basename "$i")
    exclude=false
    for j in "${dont_run[@]}"; do
        if [ "$filename" == "$j" ]; then
            exclude=true
            break
        fi
    done

    if [ $exclude == false ]; then
        echo "Running script $i"
        execute_sql_script "$i"
    fi
done

# Function to load data into tables
load_data_into_table() {
    local csv_path=$1
    local table_name=$2
    sudo mysql $DB_NAME <<EOF
LOAD DATA INFILE '$csv_path' INTO TABLE $table_name
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
EOF
}

data_files=()
table_names=()

superheated_folder=/var/lib/mysql-files/data/.*/superheated
table_data="TableKey.txt"

# Recursively find all files in the ../data directory and its subdirectories
for i in $(find /var/lib/mysql-files/data -type f); do

    filename=$(basename "$i")
    dirpath=$(dirname "$i")
    data_file="$i"
    table_name=""

    if [[ "$filename" == "$table_data" ]]; then
        continue
    fi
    
    if [[ "$dirpath" =~ $superheated_folder ]]; then

        # Extract parts of the filename
        prefix="${filename%%_*}" # superheated
        middle="${filename#*_}"  # r410a_3000_4000.csv
        middle="${middle%_*}"    # r410a_3000
        suffix="${filename##*_}" # 4000.csv

        # Extract the numeric parts
        num1="${middle##*_}" # 3000
        num2="${suffix%%.*}" # 4000

        new_num1="pa${num1}"
        new_num2="pa${num2}"

        table_name="${prefix}_${middle%_*}_${new_num1}_${new_num2}"
    else
        filename_no_ext="${filename%.*}"
        table_name="${filename_no_ext}"
    fi

    data_files+=("$data_file")
    table_names+=("$table_name")
done



# Load data into tables
for i in "${!data_files[@]}"; do
    echo "Loading data from ${data_files[$i]} into ${table_names[$i]}"
    load_data_into_table "${data_files[$i]}" ${table_names[$i]}
done
