#!/bin/sh -l

# Setup variables
path=$1
token=$2

# Install dotnet
dotnet tool install -g dotnet-format

# Set the path to the tool
export PATH="$PATH:/github/home/.dotnet/tools"

# Confirm existence of folder
if [ -d $path ]; then

    # Announce that the path exists
    echo "$path exists"

    # Format files in folder
    dotnet format $path -f

    # Check for changes
    if [ -n "$(git status --porcelain)" ]; then
        # Changes
        echo "Changes detected"

        # Configure Git
        git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
        git config --global user.name "github-actions[bot]"

        # Commit
        git add -A
        git commit -m "Auto-format Bot"

        # Push
        git push

    else
        # No changes
        echo "No changes detected"

    fi

else
    echo "$path does not exist"


fi