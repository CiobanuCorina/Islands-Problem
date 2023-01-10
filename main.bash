#!/bin/bash

declare -A matrix
num_rows=0
num_columns=0
result=-1
last_inserted_index=-1

function visit () {
    declare -n local array="$1"
    declare -A arraySet
    last_inserted_index=$2
    arraySet[$last_inserted_index]=$3
    last_row=$(($4 - 1))
    last_column=$(($5 - 1))
    while [ "${#arraySet[@]}" -ne 0 ]
    do
    	row=$last_inserted_index
    	column=${arraySet[$last_inserted_index]}
    	unset arraySet[$last_inserted_index]
    	if [[ ${arr[$row,$column]} == 1 ]]; then
    	array[$row,$column]=0
    	nextRow=$((row - 1))
        if [[ -v "array[$nextRow,$column]" ]]; then
            if (( ${array[$(($row-1)),$column]} == 1 )); then
                arraySet[$nextRow]=$column
                last_inserted_index=$nextRow
            fi
        fi
        nextRow=$((row + 1))
        if [[ -v "array[$nextRow,$column]" ]]; then
        if (( ${array[$(($row+1)),$column]} == 1 )); then
            arraySet[$nextRow]=$column
            last_inserted_index=$nextRow
            fi
        fi
        nextColumn=$((column - 1))
        if [[ -v "array[$row,$nextColumn]" ]]; then
        if (( ${array[$row,$(($column-1))]} == 1 )); then
            arraySet[$row]=$nextColumn
            last_inserted_index=$row
            fi
        fi
        nextColumn=$((column + 1))
        if [[ -v "array[$row,$nextColumn]" ]]; then
        if (( ${array[$row,$(($column+1))]} == 1 )); then
            arraySet[$row]=$nextColumn
            last_inserted_index=$row
            fi
        fi
        result=1
        else
        result=0
        fi
    done
}

numIslands () {
  declare -n local arr="$1"
  islandsNr=0
  for((i=0;i<$2;i++)) do
        for((j=0;j<$3;j++))do
                visit arr $i $j $num_rows $num_columns
                ((islandsNr+=$result))
        done
   done
   echo "islands number"
   echo $islandsNr
}

read -p "Enter number of rows " num_rows
read -p "Enter number of columns " num_columns

re="^[0-9]+$"
if ! [[ $num_rows =~ $re || $num_columns =~ $re ]]; then
    echo "Only numbers allowed!"
    exit 1
fi

for ((i=0;i<num_rows;i++)) do
    for ((j=0;j<num_columns;j++)) do
    	read -p "Enter matrix[$i,$j]" number
    	if [[ '[01]' =~ $number ]]; then 
    	    matrix[$i,$j]=$number
    	else 
    	    echo "Only 0 and 1 allowed!"
    	    exit 1
    	fi
    done
done
for ((i=0;i<num_rows;i++)) do
    for ((j=0;j<num_columns;j++)) do
        printf ${matrix[$i,$j]}
    done
    echo
done

numIslands matrix $num_rows $num_columns
