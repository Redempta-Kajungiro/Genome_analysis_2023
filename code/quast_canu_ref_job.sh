#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J quast_canu_ref_job.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools  quast/5.0.2

#Define variables
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu
REF=/home/redeath/Genome_analysis_2023/work/work_canu
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_quast/canu_q

#QUAST is a software evaluating the quality of genome assemblies by computing various metrics
#Run QUAST for contigs assembled using Canu with a reference genome
quast.py ${INPUT_FILE}/faecium.contigs.fasta -r ${REF}/GCF_009734005.1_ASM973400v2_genomic.fna.gz -o ${OUTPUT_FILE}/faecium_quast_ref_report
