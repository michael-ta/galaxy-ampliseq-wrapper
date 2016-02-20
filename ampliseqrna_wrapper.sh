# shell script for running ampliseq RNA workflow

REF_FILE=$1
BAM_FILE=$2
BED_FILE=$3
SUMMARY_FILE=$4
OUTPUT_FILE=$5
OUTPUTS_DIR=$6
JOB_WORKING_DIR=$(dirname $6)

# make a symbolic link to the bam file and create the index
ln -s "$BAM_FILE" "$JOB_WORKING_DIR/temp.bam"
WORKING_BAM="$JOB_WORKING_DIR/temp.bam"
samtools index $WORKING_BAM

# run the ampliseq rna workflow script
echo "running ampliseq rna analysis"
eval "cd $JOB_WORKING_DIR && $TS_AMPLISEQRNA/run_ampliseqrna.sh -l -O $SUMMARY_FILE $REF_FILE $WORKING_BAM $BED_FILE"

mv "$JOB_WORKING_DIR/tmp.amplicon.cov.xls" "$OUTPUT_FILE"
