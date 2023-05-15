#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J mapping_jobB.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#Define variable
INPUT_FILE=/home/redeath/Genome_analysis_2023/data/transcriptomics_data/raw_data/RNA_Seq_BH
REFERENCE=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu/faecium.contigs.fasta
OUTPUT_FILE=/home/redeath/Genome_analysis_2023/work/work_mapping/RNASeq_BH
ANNOTATION_FILE=/home/redeath/Genome_analysis_2023/work/work-annotation/annotation

# Load modules
module load bioinfo-tools  bamtools/2.5.1 samtools/1.17 htseq/2.0.2 bwa/0.7.17

#Now do  mapping and counting
for SAMPLE in trim_paired_ERR1797972 trim_paired_ERR1797973 trim_paired_ERR1797974
do
    #Index the genome assembly
    bwa index $REFERENCE
    #Map the reads
    bwa mem $REFERENCE $INPUT_FILE/${SAMPLE}_pass_1.fastq.gz $INPUT_FILE/${SAMPLE}_pass_2.fastq.gz | samtools sort -o ${SAMPLE}.bam -
    #Index the sorted alignments to improve search speed
    samtools index ${SAMPLE}.bam
    #Count features
   htseq-count --format=bam --stranded=yes --type=CDS --order=pos --idattr=locus_tag ${SAMPLE}.bam $ANNOTATION_FILE/faecium_no_fasta.gff > ${SAMPLE}_htseq_counts.txt
done
