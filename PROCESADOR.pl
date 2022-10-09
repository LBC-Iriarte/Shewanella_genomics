#!/usr/bin/perl
 
$i=1;
$ii = $ARGV[1];
chomp $outtype;
open (secuencia,$ARGV[0]) or die "No se encuentra archivo\n";
	while (<secuencia>){
	if (/>/){
	print ">$ii.$i\n";
	$i++;}
	else {print $_;}
	}
