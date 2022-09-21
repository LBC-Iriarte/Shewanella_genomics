#!/bin/bash

##Author: German Matias Traglia, Ph.D
##Address: Departamento de Desarrollo Biotecnologico, Instituto de Higiene, Facultad de Medicina, Universidad de La Republica, Montevideo, Uruguay
##Description: It fulfills a function similar to the script "count_GO_genomes_2.sh" but it does so on a collection of genomes that have been functionally annotated using EggNog.
##Usage: sh run_func.sh [.emapper.annotations list in file text]

argv=$1 ## list of emapper.annotations file
cat $1 > temp
list=$(cat temp)
for list in $list
do
sh count_GO_genomes_2.sh $list
done
	rm -rf temp
exit
