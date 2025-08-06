#!/bin/bash

# Cline Rules Weekly Sync Script
# This script syncs your fork with the upstream cline/prompts repository

set -e

REPO_DIR="$HOME/workspace/clinerules"
BACKUP_DIR="$HOME/.clinerules-backups"

echo "🔄 Starting Cline Rules sync..."

# Navigate to the repository
cd "$REPO_DIR"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create a timestamped backup before syncing
BACKUP_NAME="clinerules-backup-$(date +%Y%m%d-%H%M%S)"
echo "📦 Creating backup: $BACKUP_NAME"
cp -r .clinerules "$BACKUP_DIR/$BACKUP_NAME"

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

# Show what changed
echo "📋 Recent changes:"
git log --oneline -10

echo "✅ Sync complete!"
echo "📦 Backup stored at: $BACKUP_DIR/$BACKUP_NAME"
echo "🔗 Your .clinerules are updated with the latest community rules"
