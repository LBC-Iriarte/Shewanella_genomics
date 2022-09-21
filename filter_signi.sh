#!/bin/bash

##Author: German Matias Traglia, Ph.D
##Address: Departamento de Desarrollo Biotecnológico, Instituto de Higiene, Facultad de Medicina, Universidad de La República, Montevideo, Uruguay 
##Description:Extracts the category or level of the GO terms that were significant from the Fisher test.
##Usage: sh filter_signi.sh [GOterm list] [go_function.tab]

argv=$1 ## GO term list (from fisher test) 
argv2=$2 ## File that contain : [Go_Term];[Level name]

cat $argv > tmp

lista=$(cat tmp)

for lista in $lista
do
cat $argv2 | grep $lista >> sign_pvalue_assign_func.tab
done
	rm -rf tmp
exit
