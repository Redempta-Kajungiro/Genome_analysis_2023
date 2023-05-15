#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J canu_job.sh
#SBATCH  --mail-user redempta-athanas.kajungiro.4152@student.uu.se
#SBATCH  --mail-type=ALL

#load modules
module load bioinfo-tools canu/2.2

#Define variables

INPUT_PACBIO=/home/redeath/Genome_analysis_2023/data/genomics_data/raw_data/pacBio
INPUT_NANOPORE=/home/redeath/Genome_analysis_2023/data/genomics_data/raw_data/nanopore

#Assembling nanopore and pacbio using Canu
canu \
 -p faecium -d faecium-mix_canu \
 -pacbio ${INPUT_PACBIO}/*.subreads.fastq.gz \
  maxThreads=4 \
  genomeSize=3.4m \
  useGrid=false \
 -nanopore ${INPUT_NANOPORE}/E745_all.fasta.gz
