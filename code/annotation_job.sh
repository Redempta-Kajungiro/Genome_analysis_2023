#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J annotation_job.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools  prokka/1.45-5b58020

#Define variables
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu
#REF=/home/redeath/Genome_analysis_2023/work/work_anno
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/annotation

#Prokka requires assembled contigs

prokka --outdir ${OUTPUT_FILE} --genus Enterococcus --prefix faecium  ${INPUT_FILE}/faecium.contigs.fasta

