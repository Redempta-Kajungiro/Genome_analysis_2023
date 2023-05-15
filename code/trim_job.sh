#!/bin/bash
#SBATCH -A uppmax2023-2-8 
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00 
#SBATCH -J trim_job
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL 

#Define variable
INPUT_DIR=/home/redeath/Genome_analysis_2023/data/genomics_data/raw_data/illumina
OUTPUT_DIR=/home/redeath/Genome_analysis_2023/analyses/Quality_check_DNA/Illumina/trimmed_Tr

#Load module
module load bioinfo-tools 
module load trimmomatic/0.39
module load FastQC/0.11.9
#Read Quality Control

#Trim data 
trimmomatic PE -phred33 \
-threads 2 \
$INPUT_DIR/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz \
$INPUT_DIR/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz \
$OUTPUT_DIR/E745-1.L500_SZAXPI015146-56_1_trimmed_R1.fastq \
$OUTPUT_DIR/E745-1.L500_SZAXPI015146-56_1_trimmed_U1.fastq \
$OUTPUT_DIR/E745-1.L500_SZAXPI015146-56_2_trimmed_R2.fastq \
$OUTPUT_DIR/E745-1.L500_SZAXPI015146-56_2_trimmed_U2.fastq \
ILLUMINACLIP:/sw/apps/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:20 TRAILING:20 SLIDINGWINDOW:4:15 MINLEN:36 \

##Run fastqc again on the filtered reads using FASTQC
fastqc $OUTPUT_DIR/E745-1.L500_SZAXPI015146-56_1_trimmed_R1.fastq $OUTPUT_DIR/E745-1.L500_SZAXPI015146-56_2_trimmed_R2.fastq