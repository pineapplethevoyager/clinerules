#!/bin/bash

# Cline Rules Weekly Sync Script
# This script syncs your fork with the upstream cline/prompts repository

set -e

REPO_DIR="$HOME/workspace/clinerules"
BACKUP_DIR="$HOME/.clinerules-backups"

echo "🔄 Starting Cline Rules sync..."

# Navigate to the repository
cd "$REPO_DIR"

# Fetch latest changes from upstream
echo "⬇️  Fetching changes from upstream..."
git fetch upstream

# Check if we're on main branch, if not switch to it
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🔀 Switching to main branch..."
    git checkout main
fi

# Merge upstream changes
echo "🔀 Merging upstream changes..."
git merge upstream/main

# Push updates to your fork
echo "⬆️  Pushing updates to your fork..."
git push origin main

# Copy .clinerules to ~/Documents/Cline/Rules
echo "📂 Copying .clinerules to ~/Documents/Cline/Rules..."

# Create the destination directory if it doesn't exist
mkdir -p "$HOME/Documents/Cline"

# Handle existing Rules directory/symlink
if [ -L "$HOME/Documents/Cline/Rules" ]; then
    echo "🔗 Removing existing symlink..."
    rm "$HOME/Documents/Cline/Rules"
elif [ -d "$HOME/Documents/Cline/Rules" ]; then
    echo "🗑️  Removing existing ~/Documents/Cline/Rules..."
    rm -rf "$HOME/Documents/Cline/Rules" 2>/dev/null || echo "⚠️  Could not remove existing Rules directory, continuing..."
fi

# Copy the directory
echo "📁 Copying files..."
cp -r "$REPO_DIR/.clinerules" "$HOME/Documents/Cline/Rules"

# Show what changed
echo "📋 Recent changes:"
git log --oneline -10

echo "✅ Sync complete!"
echo "📦 Backup stored at: $BACKUP_DIR/$BACKUP_NAME"
echo "📁 .clinerules copied to ~/Documents/Cline/Rules"
