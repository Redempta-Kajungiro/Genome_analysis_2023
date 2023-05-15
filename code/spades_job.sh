#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J spades_job.sh
#SBATCH  --mail-user 
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools spades/3.15.5
#Define variables

#INPUT_PACBIO=/home/redeath/Genome_analysis_2023/data/genomics_data/raw_data/pacBio
INPUT_NANOPORE=/home/redeath/Genome_analysis_2023/data/genomics_data/raw_data/nanopore
INPUT_ILLUMINA=/home/redeath/Genome_analysis_2023/data/genomics_data/raw_data/illumina
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_Spades


#SPADES assembly pacbio or nanopore and illumina reads for gap closure and repeat resolution
spades.py -1 ${INPUT_ILLUMINA}/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz -2 ${INPUT_ILLUMINA}/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz \
    --nanopore ${INPUT_NANOPORE}/E745_all.fasta.gz \
    -o ${OUTPUT_FILE}/spades_output

