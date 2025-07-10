#!/bin/bash

# Check if a dataset parameter was provided
if [ $# -eq 0 ]; then
    echo "Error: No dataset specified."
    echo "Usage: $0 <dataset>"
    echo "Available datasets: MatOnto, OBI, SWEET"
    exit 1
fi

# Store the dataset parameter
DATASET=$1

# Validate dataset
if [[ ! "$DATASET" =~ ^(MatOnto|OBI|SWEET)$ ]]; then
    echo "Error: Invalid dataset '$DATASET'."
    echo "Available datasets: MatOnto, OBI, SWEET"
    exit 1
fi

echo "Processing $DATASET dataset..."

# Run commands with the provided dataset
python create_jsonl_dataset_judge.py $DATASET --judge gpt-4o --reasoner "deepseek-chat,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge gpt-4o --reasoner "gpt-4o,deepseek-chat,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge gpt-4o --reasoner "gpt-4o,deepseek-chat,claude-sonnet-4-20250514"

python create_jsonl_dataset_judge.py $DATASET --judge deepseek-chat --reasoner "gpt-4o,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge deepseek-chat --reasoner "gpt-4o,deepseek-chat,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge deepseek-chat --reasoner "gpt-4o,deepseek-chat,claude-sonnet-4-20250514"

python create_jsonl_dataset_judge.py $DATASET --judge claude-sonnet-4-20250514 --reasoner "gpt-4o,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge claude-sonnet-4-20250514 --reasoner "deepseek-chat,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge claude-sonnet-4-20250514 --reasoner "gpt-4o,deepseek-chat,claude-sonnet-4-20250514"

python create_jsonl_dataset_judge.py $DATASET --judge gemini-2.5-pro --reasoner "gpt-4o,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge gemini-2.5-pro --reasoner "deepseek-chat,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py $DATASET --judge gemini-2.5-pro --reasoner "gpt-4o,deepseek-chat,gemini-2.5-pro"

echo "Processing $DATASET judge dataset complete!"