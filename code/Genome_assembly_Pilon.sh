#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J Genome_assembly_Pilon.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#Define variable
REFERENCE=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu/faecium.contigs.fasta
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/Genome_evalution/E_faecium.sorted.bam
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/Genome_evalution
read1=/home/redeath/Genome_analysis_2023/work/work_Spades/spades_output/scaffolds.fasta
# Load modules
module load bioinfo-tools  bamtools/2.5.1 samtools/1.17 bwa/0.7.17 java/sun_jdk1.8.0_151 Pilon/1.24
#Mapping
#Index the genome assembly
bwa index $REFERENCE
#Aligning reads to the assembled genome
bwa mem $REFERENCE $read1 > E_faecium.sam
samtools view -S -b E_faecium.sam > E_faecium.bam
samtools sort E_faecium.bam -o E_faecium.sorted.bam
#Index the sorted alignments to improve search speed
samtools index E_faecium.sorted.bam
#Running Pilon to fix misassemblies illumina+Nanopore_contigs_on_PacBio+Nanopore
java -jar $PILON_HOME/pilon.jar --genome $REFERENCE --frags E_faecium.sorted.bam --outdir $OUTPUT_FILE --output E_faecium_improved

##Evaluating the improved sequence using quast
#load modules
module load bioinfo-tools  quast/5.0.2

#Define variables
INPUT_FILE=/home/redeath/Genome_analysis_2023/work/Genome_evalution/E_faecium_improved.fasta
REF=/home/redeath/Genome_analysis_2023/work/work_canu
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/Genome_evalution
#QUAST is a software evaluating the quality of genome assemblies by computing various metrics
quast.py ${INPUT_FILE} -r ${REF}/GCF_009734005.1_ASM973400v2_genomic.fna -o ${OUTPUT_FILE}/faecium_quast_ref_improved_report

