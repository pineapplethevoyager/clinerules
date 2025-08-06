#!/bin/bash

# Cline Rules Sync Script
# This script copies all .clinerule files to target directories

set -e

REPO_DIR="$HOME/workspace/clinerules"

# List of target directories to copy rules to
TARGET_DIRECTORIES=(
    "$HOME/workspace/blackout/.clinerules"
    # Add more directories here as needed
    # "$HOME/workspace/other-project/.clinerules"
    # "$HOME/workspace/another-project/.clinerules"
)

echo "🔄 Starting Cline Rules copy process..."

# Navigate to the repository
cd "$REPO_DIR"

# Check if .clinerules directory exists
if [ ! -d ".clinerules" ]; then
    echo "❌ Error: .clinerules directory not found in $REPO_DIR"
    exit 1
fi

echo "📂 Found .clinerules directory with the following rules:"
ls -la .clinerules/

# Copy rules to each target directory
for target_dir in "${TARGET_DIRECTORIES[@]}"; do
    echo ""
    echo "📁 Processing target: $target_dir"
    
    # Create the target directory if it doesn't exist
    if [ ! -d "$target_dir" ]; then
        echo "📂 Creating directory: $target_dir"
        mkdir -p "$target_dir"
    else
        echo "📂 Directory already exists: $target_dir"
    fi
    
    # Copy all files from .clinerules to target directory
    echo "📋 Copying all .clinerule files..."
    cp -r "$REPO_DIR/.clinerules/"* "$target_dir/"
    
    # Show what was copied
    echo "✅ Successfully copied rules to: $target_dir"
    echo "📋 Files in target directory:"
    ls -la "$target_dir/"
done

echo ""
echo "✅ Sync complete!"
echo "📁 Rules copied to ${#TARGET_DIRECTORIES[@]} target directories"
