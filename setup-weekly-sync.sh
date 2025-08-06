#!/bin/bash

# Setup script to configure weekly sync for Cline Rules
# This adds an alias to your shell profile for easy syncing

SCRIPT_PATH="$HOME/workspace/clinerules/sync-clinerules.sh"
SHELL_PROFILE=""

# Detect shell and profile file
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [[ "$SHELL" == *"bash"* ]]; then
    SHELL_PROFILE="$HOME/.bash_profile"
fi

if [[ -n "$SHELL_PROFILE" ]]; then
    echo "🔧 Setting up weekly sync alias..."
    
    # Check if alias already exists
    if ! grep -q "alias sync-clinerules" "$SHELL_PROFILE" 2>/dev/null; then
        echo "" >> "$SHELL_PROFILE"
        echo "# Cline Rules Weekly Sync" >> "$SHELL_PROFILE"
        echo "alias sync-clinerules='$SCRIPT_PATH'" >> "$SHELL_PROFILE"
        echo "✅ Added 'sync-clinerules' alias to $SHELL_PROFILE"
        echo "💡 Run 'source $SHELL_PROFILE' or restart your terminal to use the alias"
    else
        echo "✅ Alias already exists in $SHELL_PROFILE"
    fi
else
    echo "⚠️  Could not detect shell profile. Manually add this alias:"
    echo "alias sync-clinerules='$SCRIPT_PATH'"
fi

echo ""
echo "📋 Usage:"
echo "  sync-clinerules    # Sync with community rules"
echo "  Weekly sync recommended to get latest community updates"
