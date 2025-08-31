#!/bin/bash

# Setup script for the Leeger repository development environment
# This script installs the necessary dependencies for Excel export functionality

set -e

echo "🔧 Setting up Leeger development environment..."

# Check Python version
echo "🐍 Python version:"
python3 --version

# Install system dependencies
echo "📦 Installing system dependencies..."

# Install numpy via system package manager (avoids build issues)
if ! python3 -c "import numpy" 2>/dev/null; then
    echo "Installing numpy..."
    sudo apt update -qq
    sudo apt install -y python3-numpy
    echo "✅ numpy installed successfully"
else
    echo "✅ numpy already available"
fi

# Install openpyxl for Excel functionality
if ! python3 -c "import openpyxl" 2>/dev/null; then
    echo "Installing openpyxl..."
    pip install --user openpyxl
    echo "✅ openpyxl installed successfully"
else
    echo "✅ openpyxl already available"
fi

echo "🧪 Testing leeger package import..."
# Test if the leeger package can be imported
if PYTHONPATH="$(pwd):$PYTHONPATH" python3 -c "from leeger.util.excel import leagueToExcel; print('✅ leeger package import successful')"; then
    echo "🎉 Setup completed successfully!"
    echo "📋 You can now run the Excel export with: ./run_excel_export.sh"
else
    echo "❌ Setup failed - leeger package cannot be imported"
    exit 1
fi