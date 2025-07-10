@echo off
setlocal enabledelayedexpansion

:: Check if a dataset parameter was provided
if "%~1"=="" (
    echo Error: No dataset specified.
    echo Usage: %0 ^<dataset^>
    echo Available datasets: MatOnto, OBI, SWEET
    exit /b 1
)

:: Store the dataset parameter
set DATASET=%~1

:: Validate dataset
if /i not "%DATASET%"=="MatOnto" if /i not "%DATASET%"=="OBI" if /i not "%DATASET%"=="SWEET" (
    echo Error: Invalid dataset '%DATASET%'.
    echo Available datasets: MatOnto, OBI, SWEET
    exit /b 1
)

echo Processing %DATASET% dataset...

:: Run commands with the provided dataset
python create_jsonl_dataset_judge.py %DATASET% --judge gpt-4o --reasoner "deepseek-chat,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py %DATASET% --judge deepseek-chat --reasoner "gpt-4o,claude-sonnet-4-20250514,gemini-2.5-pro"
python create_jsonl_dataset_judge.py %DATASET% --judge claude-sonnet-4-20250514 --reasoner "gpt-4o,deepseek-chat,gemini-2.5-pro"
python create_jsonl_dataset_judge.py %DATASET% --judge gemini-2.5-pro --reasoner "gpt-4o,deepseek-chat,claude-sonnet-4-20250514"

echo Processing %DATASET% judge dataset complete!