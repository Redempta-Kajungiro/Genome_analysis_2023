#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J spades_quast_job.sh
#SBATCH  --mail-user <email> 
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools  quast/5.0.2

#Define variables
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_Spades/spades_output
REF=//home/redeath/Genome_analysis_2023/work/work_Spades
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_Spades

#QUAST is a software evaluating the quality of genome assemblies by computing various metrics
quast.py ${INPUT_FILE}/scaffolds.fasta -r ${REF}/GCF_009734005.1_ASM973400v2_genomic.fna.gz -o ${OUTPUT_FILE}/faecium_SP_quast_ref_report
