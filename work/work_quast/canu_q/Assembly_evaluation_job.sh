#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 03:00:00
#SBATCH -J Assembly_evaluation_job.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools  quast/5.0.2

#Define variables
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_quast

#QUAST is a software evaluating the quality of genome assemblies by computing various metrics
quast.py ${INPUT_FILE}/faecium.contigs.fasta -o ${OUTPUT_FILE}/faecium_quast_report
