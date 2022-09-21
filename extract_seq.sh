#!/bin/bash

##Author: German Matias Traglia, Ph.D
##Address: Departamento de Desarrollo Biotecnologico, Instituto de Higiene, Universidad de La Republica, Montevideo, Uruguay
##Description:Extract a sequence or list of amino acid sequences from a fasta file
##Usage: sh extract_seq [list_Amino_acid_sequence] [Name_Output_Fasta_file] [Input_Fasta_file]

argv=$1 ## Input: list of proteins
argv2=$2 ## Output: name of output
argv3=$3 ## Input: file sequence (Fasta format)

cat $argv > tmp
list=$(cat tmp)
for list in $list
do
samtools faidx $argv3 $list >> $argv2
done
	rm -rf tmp
exit
