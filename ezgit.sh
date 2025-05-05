#!/bin/bash

# GitHub CLI Menu Script + Watch & Merge Option
# Revision: 1.3 (Patched for remote, push, empty commits)

print_header() {
  echo -e "\n🔧 GitHub CLI Project Menu"
  echo    "=========================="
  echo    "1. Create new GitHub repo from folder"
  echo    "2. Clone existing repo"
  echo    "3. Merge one folder into another"
  echo    "4. Set up Watch & Auto-Merge (every 24h)"
  echo    "5. Exit"
}

create_repo() {
  read -p "📝 Repo name: " repo_name
  read -p "📁 Local folder path (e.g., ~/my-project): " folder_path
  read -p "🔒 Visibility (private/public) [private]: " visibility
  visibility=${visibility:-private}

  folder_path=$(eval echo "$folder_path")
  if [ ! -d "$folder_path" ]; then
    echo "❌ Directory does not exist."
    return
  fi

  cd "$folder_path" || return

  git init
  git remote remove origin 2>/dev/null

  git add .
  if ! git diff --cached --quiet; then
    git commit -m "Initial commit"
  else
    echo "⚠️ No files staged. Repo will be created empty."
  fi

  git branch -M main

  if ! gh auth status &>/dev/null; then
    echo "🔐 GitHub login required..."
    gh auth login
  fi

  if gh repo view "$repo_name" &>/dev/null; then
    echo "⚠️ Repo '$repo_name' already exists on GitHub."
  else
    gh repo create "$repo_name" --"$visibility" --source=. --remote=origin --push
  fi

  if ! git remote get-url origin &>/dev/null; then
    user=$(gh api user --jq .login)
    git remote add origin "https://github.com/$user/$repo_name.git"
  fi

  git push -u origin main
  echo "✅ Repo '$repo_name' created and pushed."
}

clone_repo() {
  read -p "🌐 GitHub repo URL (e.g., https://github.com/user/repo.git): " repo_url
  read -p "📁 Destination folder (optional): " dest

  if [ -z "$dest" ]; then
    git clone "$repo_url"
  else
    git clone "$repo_url" "$dest"
  fi
  echo "✅ Repo cloned."
}

merge_repos() {
  read -p "📁 Source folder to merge from: " src
  read -p "📁 Target folder to merge into: " tgt

  src=$(eval echo "$src")
  tgt=$(eval echo "$tgt")

  if [ ! -d "$src" ] || [ ! -d "$tgt" ]; then
    echo "❌ One or both directories not found."
    return
  fi

  cd "$tgt" || return

  git remote add tempmerge "$src" 2>/dev/null
  git fetch tempmerge

  if ! git merge tempmerge/main --allow-unrelated-histories -m "Merged from $src"; then
    echo "⚠️ Merge failed due to conflicts."
  else
    git push
    echo "✅ Merge completed and pushed."
  fi

  git remote remove tempmerge
}

setup_watch_merge() {
  read -p "📁 Watched source folder (absolute path): " src
  read -p "📁 Target folder to auto-merge into: " tgt
  script_path="$HOME/.git-auto-merge.sh"
  log_path="$HOME/auto-merge.log"

  src=$(eval echo "$src")
  tgt=$(eval echo "$tgt")

  if [ ! -d "$src" ] || [ ! -d "$tgt" ]; then
    echo "❌ One or both paths are invalid."
    return
  fi

  cat > "$script_path" <<EOF
#!/bin/bash
SRC="$src"
TGT="$tgt"
LOG="$log_path"

cd "\$TGT" || { echo "❌ [\$(date)] Failed to cd to \$TGT" >> "\$LOG"; exit 1; }

git remote add auto_merge "\$SRC" 2>/dev/null
git fetch auto_merge

if ! git merge auto_merge/main --allow-unrelated-histories -m "🕒 Auto-merged from \$SRC"; then
  echo "❌ [\$(date)] Merge failed (conflicts or fetch issue)" >> "\$LOG"
  git merge --abort
else
  git push
  echo "✅ [\$(date)] Merge successful" >> "\$LOG"
fi

git remote remove auto_merge
EOF

  chmod +x "$script_path"

  crontab -l 2>/dev/null | grep -v "$script_path" | crontab -
  (crontab -l 2>/dev/null; echo "0 */24 * * * $script_path") | crontab -

  echo "⏱️ Watch set up to auto-merge every 24 hours."
  echo "📝 Logs will go to: $log_path"
  echo "🗂️ Source: $src → Target: $tgt"
}

# === Main Menu ===
while true; do
  print_header
  read -p "Choose an option [1-5]: " choice
  case "$choice" in
    1) create_repo ;;
    2) clone_repo ;;
    3) merge_repos ;;
    4) setup_watch_merge ;;
    5) echo "👋 Goodbye."; exit 0 ;;
    *) echo "❌ Invalid option. Try again." ;;
  esac
done
