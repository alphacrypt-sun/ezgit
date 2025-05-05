#!/bin/bash

# github-cli-menu.sh – GitHub Automation CLI
# Version: 1.3
# Updated: May 5, 2025

clear

print_menu() {
  echo "🔧 GitHub CLI Project Menu"
  echo "==========================="
  echo "1. Create new GitHub repo from current folder"
  echo "2. Clone existing repo"
  echo "3. Merge one folder into another"
  echo "4. Set up Watch & Auto-Merge (every 24h)"
  echo "5. Update & Push Local Repo to GitHub"
  echo "6. Exit"
}

auto_detect_url() {
  git remote get-url origin 2>/dev/null || echo ""
}

create_repo() {
  repo_name=$(basename "$PWD")
  read -p "🔒 Visibility (private/public) [private]: " visibility
  visibility=${visibility:-private}
  echo "📦 Creating repo '$repo_name' as $visibility..."

  git init -q 2>/dev/null
  git add .
  git commit -m "Initial commit" 2>/dev/null

  gh repo create "$repo_name" --$visibility --source=. --remote=origin --push
}

clone_repo() {
  read -p "🌐 GitHub repo URL (e.g., https://github.com/user/repo.git): " repo_url
  git clone "$repo_url"
}

merge_folders() {
  read -p "📁 Source folder to merge from (absolute path): " src
  read -p "📁 Target folder to merge into (absolute path): " tgt

  if [[ ! -d "$src" || ! -d "$tgt" ]]; then
    echo "❌ One or both directories not found. Use absolute paths."
    return
  fi

  cp -r "$src"/* "$tgt"/
  echo "✅ Merged '$src' into '$tgt'"
}

setup_watch() {
  read -p "📁 Watched source folder (absolute path): " src
  read -p "📁 Target folder to auto-merge into (absolute path): " tgt

  if [[ ! -d "$src" || ! -d "$tgt" ]]; then
    echo "❌ One or both paths are invalid."
    return
  fi

  cronjob="0 */24 * * * cp -r $src/* $tgt/ >> ~/auto-merge.log 2>&1"
  (crontab -l 2>/dev/null; echo "$cronjob") | crontab -
  echo "🕒 Auto-merge scheduled every 24h."
}

push_update() {
  repo_name=$(basename "$PWD")
  repo_url=$(auto_detect_url)

  if [[ -z "$repo_url" || "$repo_url" != https://github.com/* ]]; then
    read -p "🌐 GitHub repo URL (e.g., https://github.com/user/repo.git): " repo_url
  fi

  if [[ -z "$repo_url" ]]; then
    echo "❌ GitHub repo URL is required."
    return
  fi

  git init -q
  git add .
  git commit -m "Update $(date '+%Y-%m-%d %H:%M:%S')" 2>/dev/null
  git remote remove origin 2>/dev/null
  git remote add origin "$repo_url"
  git branch -M main
  git push -u origin main
  echo "✅ Repo '$repo_name' updated and pushed to GitHub."
}

while true; do
  print_menu
  echo ""
  read -p "Choose an option [1-6]: " choice

  case $choice in
    1) create_repo;;
    2) clone_repo;;
    3) merge_folders;;
    4) setup_watch;;
    5) push_update;;
    6) echo "👋 Exiting..."; exit 0;;
    *) echo "❌ Invalid option. Try again.";;
  esac

done
