# Shewanella_genomics
Comparative genome analysis of the genus Shewanella unravels the association of key genetic traits with known and potential pathogenic lineages 

Gabriela N. Cerbino, German M. Traglia, Teolincacihuatl Ayala Nuñez, Gisela Parmeciano Di Noto, María Soledad Ramírez, Daniela Centrón, Andrés Iriarte*, Cecilia Quiroga*.


## Methods

## GO term enrichment analysis

## Workflow:

1. Download genomes 

2.EggNOG mapper

3.run_func.sh (input= faa file (proteome from each genome)- FASTA file with Amino acid sequence, output= Eggnog output files from each faa file)

4.fisher3.R (input=matrix file - output = table_fisher.csv (examples in folder: clin1_v_env, clin2_v_env, etc))

5.filter_signi.sh (input=table_fisher.csv, output=sign_pvalue_assign_func_c1_v_c2.tab (examples in folder: clin1_v_env, clin2_v_env, etc))

Conservation:

1 extract_seq.sh (KatG,hemB, etc)

2 GOATOOLS

3 blastp: all-to all of each amino acid protein

4 PROSITE & Pfam (ONLINE webserver)

– Code list:

The function of each script is described. The details of how to use each "script" are commented within the code.

## Scripts

$ count_GO_genomes_2.sh
Read and count each GO term on the functional annotation generated by EggNog Mapper v2 on a single genome.

$ run_func.sh
It fulfills a function similar to the script "count_GO_genomes_2.sh" but it does so on a collection of genomes that have been functionally annotated using EggNog. The output is a matrix of presence/absence of the GO and each of the included genomes.

$ fisher3.R
Performs the Fisher test from an MxN matrix with the following columns: “Type Functional Term [for example: GO]”; "number term without zeros"; "cond1_Presence"; “cond2_Presence_Term”; "cond1_Absence_Term"; “cond2_Absense_Term”.

$ filter_signi.sh
Extracts the category or level of the GO terms that were significant from the Fisher test.

$ extract_seq.sh
Extract a sequence or list of amino acid sequences from a fasta file

## Command lines of each program.
 --EggNOG Mapper v2. 

The functional annotation of each of the genomes was performed using the following command line:

$ emapper.py -i FASTA_FILE_PROTS -o test --tax_scope bacteria

 -- GOATOOLS:
We complement the annotation of the results obtained with the script "filter_signi.sh" with one of the tools of the GOATOOLS package.

$ go_plot.py --go_file=tests/data/go_plot/go_selected.txt -r -o selected_go.png

 --PROSITE y Pfam:
We use the online servers of each database to perform the blastp.




## Phylogenetic analysis

Download genomes, clustering of orthologs, alignment, and phylogenetic analysis. 

1. Complete and draft genomes of Shewanella spp. available in Genbank until August 2019 were used in this work, resulting in 144 sequences. Coding sequences were downloaded using wget command. For instance for each CDS we run:

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/006/494/715/GCA_006494715.1_ASM649471v1/GCA_006494715.1_ASM649471v1_cds_from_genomic.fna.gz
gunzip GCA_006494715.1_ASM649471v1_cds_from_genomic.fna.gz

2. Replacing fasta headers for each organism for a three letters code and number. For each coding sequence file we run:

PROCESADOR.pl GCA_006494715.1_ASM649471v1_cds_from_genomic.fna cgd > cgd.sec

3. Each generated, recoded file was translated using transeq tool from emboss package. We run:

transeq -sequence cdg.sec -outseq temp
sed 's/_1//g' temp > cdg.faa

4. All faa files were put together in a folder. Then, orthologous genes were identified by the Get_homologues software using the OrthoMCL method. A minimum coverage of 75% (default) and identity values of 40% were set as thresholds for blastp searches. Inparalogs were not included. 

./get_homologues.pl -d ./folder_faa -e 1 -M 1 -C 75 -S 40

5. Each cluster of ortholog in the folder, generated by get_homologous.pl and named by default “folder_faa_homologs/…taxa_algOMCL_e1_S40_/ were aligned using cluster omega. For each fasta file in the folder, which is a putative orthologous groups, we run:

clustalo -i 206578_cea.60.faa --output-order=input-order -o 206578_cea.60.aln

6. All aligned sequences were concatenated to form a “super”-protein named “concatenados.fas”. For this, within the folder we run:

Concatenador.scp

7. Phylogenetic analysis was built using iqtree. The generated file “concatenados.fas” was used as input. 

iqtree-omp -s concatenados.fas -bb 1000 -m TEST

 

