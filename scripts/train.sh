#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p $models

num_threads=4
device=""
LOG_FILE=$models/perplexity_log.txt
SECONDS=0

# Define different dropout values (including 0 for no dropout)
DROPOUT_VALUES=(1.0 0.8 0.5 0.3 0.0)

# Define different embedding sizes and hidden units
EMBEDDING_SIZES=(250)
HIDDEN_UNITS=(250)

# Loop through different dropout values, embedding sizes, and hidden units
for DROPOUT in "${DROPOUT_VALUES[@]}"
do
    for EM_SIZE in "${EMBEDDING_SIZES[@]}"
    do
        for NHID in "${HIDDEN_UNITS[@]}"
        do
            LOG_FILE=$models/perplexity_log_dropout_${DROPOUT}_emsize_${EM_SIZE}_nhid_${NHID}.txt
            echo "Training model with dropout=$DROPOUT, emsize=$EM_SIZE, nhid=$NHID"
            echo "LOG_FILE: $LOG_FILE" 

            # Training the model
            (cd $tools/pytorch-examples/word_language_model &&
            CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data $data/yellow_wallpaper \
                --epochs 40 \
                --log-interval 100 \
                --emsize $EM_SIZE --nhid $NHID --dropout $DROPOUT --tied \
                --save $models/model_dropout_${DROPOUT}_emsize_${EM_SIZE}_nhid_${NHID}.pt \
                --log-perplexity $LOG_FILE
            )

            echo "time taken:"
            echo "$SECONDS seconds"

        done
    done
done

