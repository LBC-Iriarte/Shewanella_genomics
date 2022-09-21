#!/bin/bash

ls *aln | sed 's/\.aln//g'> archivos.lis
first=$(head -1 archivos.lis)
egrep ">" "$first".aln | sed 's/>//g' > organismos.lis


Organismos=$(cat organismos.lis)
for Orga in $Organismos
do      
	echo "$Orga"..................
        echo ">""$Orga" > "$Orga".tmpx
done

outfiles=$(cat archivos.lis)
for outfile in $outfiles
do
	echo ................................................"$outfile" 
	sed 's/>..*/&____/g' "$outfile".aln | sed ':a;N;$!ba;s/\n//g' |sed 's/____/\n/g' | sed 's/>/\n>/g' | egrep . > temp
	organismos=$(cat organismos.lis)
	for orga in $organismos
	do	
		echo "$orga"..................
		egrep -A1 -w "$orga" temp | egrep -v ">" >> "$orga".tmpx
	done
done
cat *.tmpx > concatenados.fas

exit
	