#!/usr/bin/bash

newcommit() {
    # Add all files
    git add .

    # Prompt for commit message
    echo -n "Enter commit message: "
    read commit_msg
    git commit -m "$commit_msg"

    # Push to remote
    git push -f origin master
}

newrepo() {
    # Initialize local repo
    git init
    
    # Add all files
    git add .
    
    # Prompt for commit message
    echo -n "Enter commit message: "
    read commit_msg
    git commit -m "$commit_msg"
    
    # Prompt for remote URL
    echo -n "Enter GitHub repo URL (https://github.com/username/repo.git): "
    read repo_url
    git remote add origin "$repo_url"
    
    # Push to remote
    git push -u origin main
    
    echo "Repository created and pushed to GitHub successfully!"
}