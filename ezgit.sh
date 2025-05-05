#!/bin/bash

# github-cli-menu.sh
# A bash menu script to automate GitHub operations using GitHub CLI (gh), git, and cron

clear

print_menu() {
  echo ""
  echo "🔧 GitHub CLI Project Menu"
  echo "=========================="
  echo "1. Create new GitHub repo from current folder"
  echo "2. Clone existing repo"
  echo "3. Merge one folder into another"
  echo "4. Set up Watch & Auto-Merge (every 24h)"
  echo "5. Update & Push Local Repo to GitHub"
  echo "6. Exit"
}

create_repo() {
  folder_path=$(pwd)
  read -p "📝 Repo name: " repo_name
  read -p "🔒 Visibility (private/public) [private]: " visibility
  visibility=${visibility:-private}

  if [ ! -d "$folder_path/.git" ]; then
    git init
    echo "# $repo_name" > README.md
    git add .
    git commit -m "Initial commit"
  fi

  gh repo create "$repo_name" --"$visibility" --source=. --remote=origin --push
  echo "✅ Repo '$repo_name' created from $folder_path and pushed to GitHub."
}

clone_repo() {
  read -p "🌐 GitHub repo URL (e.g., https://github.com/user/repo.git): " repo_url
  git clone "$repo_url"
}

merge_folders() {
  read -p "📁 Source folder to merge from (absolute path): " source_folder
  read -p "📁 Target folder to merge into (absolute path): " target_folder

  if [ ! -d "$source_folder" ] || [ ! -d "$target_folder" ]; then
    echo "❌ One or both directories not found."
    return
  fi

  cp -r "$source_folder"/* "$target_folder"
  echo "✅ Merged contents of $source_folder into $target_folder."
}

watch_and_auto_merge() {
  read -p "📁 Watched source folder (absolute path): " source_folder
  read -p "📁 Target folder to auto-merge into (absolute path): " target_folder

  if [ ! -d "$source_folder" ] || [ ! -d "$target_folder" ]; then
    echo "❌ One or both paths are invalid."
    return
  fi

  cron_job="0 */24 * * * cp -r $source_folder/* $target_folder && echo \"Merged at \$(date)\" >> ~/auto-merge.log"
  (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
  echo "✅ Auto-merge scheduled every 24 hours."
}

update_repo() {
  folder_path=$(pwd)
  read -p "🌐 GitHub repo URL (e.g., https://github.com/user/repo.git): " repo_url

  if [ -z "$repo_url" ]; then
    echo "❌ No GitHub repo URL provided."
    return
  fi

  if [ ! -d "$folder_path/.git" ]; then
    echo "❌ This directory is not a Git repository."
    return
  fi

  cd "$folder_path" || return
  git add .
  git commit -m "Update" || echo "ℹ️ No changes to commit."
  git remote add origin "$repo_url" 2>/dev/null
  git pull origin main --rebase
  git push origin main
  echo "✅ Local repository updated and pushed to $repo_url."
}

while true; do
  print_menu
  read -p "Choose an option [1-6]: " choice
  case $choice in
    1) create_repo ;;
    2) clone_repo ;;
    3) merge_folders ;;
    4) watch_and_auto_merge ;;
    5) update_repo ;;
    6) echo "👋 Goodbye!"; exit 0 ;;
    *) echo "❌ Invalid option." ;;
  esac
done
