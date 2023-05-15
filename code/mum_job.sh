#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J mum_job.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools  MUMmer/4.0.0rc1

#Define variables
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu
REF=/home/redeath/Genome_analysis_2023/work/work_canu
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work

#MUMmerplot was used for  comparing two aligned assembled genome and reference genome of the similarities between them

mummer -mum -b -c ${INPUT_FILE}/faecium.contigs.fasta  ${REF}/GCF_009734005.1_ASM973400v2_genomic.fna > mummer.mums
mummerplot -x "[0,3179422]" -y "[0,2919198]" -png -p mummer mummer.mums
