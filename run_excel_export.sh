#!/bin/bash

# Script to run the Excel export for the Leeger repository
# This script sets up the environment and runs the test-excel.py script

set -e

# Get the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LEEGER_ROOT="$SCRIPT_DIR"
E2E_DIR="$LEEGER_ROOT/e2e"

echo "Setting up environment for Excel export..."

# Check if TEMP_DIR is set, if not, set it to /tmp
if [ -z "$TEMP_DIR" ]; then
    export TEMP_DIR="/tmp"
    echo "Set TEMP_DIR to /tmp"
else
    echo "TEMP_DIR is already set to: $TEMP_DIR"
fi

# Set Python path to include the leeger module
export PYTHONPATH="$LEEGER_ROOT:$PYTHONPATH"

echo "Running Excel export script..."

# Navigate to e2e directory and run the script
cd "$E2E_DIR"
python test-excel.py

# Remove existing Excel file if it exists to avoid conflicts
EXCEL_PATH="$TEMP_DIR/excel.xlsx"
if [ -f "$EXCEL_PATH" ]; then
    echo "🗑️  Removing existing Excel file..."
    rm -f "$EXCEL_PATH"
fi

echo "Running Excel export script..."

# Navigate to e2e directory and run the script
cd "$E2E_DIR"
python test-excel.py

# Check if the Excel file was created successfully
if [ -f "$EXCEL_PATH" ]; then
    echo "✅ Excel file created successfully!"
    echo "📄 File location: $EXCEL_PATH"
    echo "📊 File size: $(ls -lh "$EXCEL_PATH" | awk '{print $5}')"
    echo "🔍 File type: $(file "$EXCEL_PATH")"
else
    echo "❌ Excel file was not created"
    exit 1
fi