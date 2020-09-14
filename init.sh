#! /bin/bash

declare -A modules

for module in modules/*
do
  if [[ -f $module  ]]
  then

    module_name=`echo $module | sed 's/.*\///g'`

    input=0
    while [[ ! $input =~ ^[yYnN]?$ ]]
    do
      read -p "Install $module_name [Y/n]: " input
    done

    if [ "$input" = "y" ] || [ "$input" = "Y" ] || [ "$input" = "" ]
    then
      modules[$module]=$module_name
    fi
  fi
done

for module in "${!modules[@]}"
do
  echo "-- Installing ${modules[$module]}..."
  bash $module
  echo "-- Done"
  echo ""
done


