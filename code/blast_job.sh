#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J blast_job.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL


#Define variable
assembled_genome=/home/redeath/Genome_analysis_2023/work/work_canu/faecium-mix_canu/faecium.contigs.fasta

# Load modules
module load bioinfo-tools  blast/2.13.0+
  
#build a blast database with our reference genome sequences
makeblastdb -in GCF_009734005.1_ASM973400v2_genomic.fna -out my_reference -parse_seqids -dbtype nucl

#blast  assembled genome sequences against the reference sequences
blastn -query $assembled_genome -db my_reference -outfmt 6 

