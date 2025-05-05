# 📘 `github-cli-menu.sh` – GitHub Automation CLI

A no-BS Bash script that simplifies daily GitHub project tasks — creating, cloning, merging, updating, and automating — all from a terminal menu. Powered by GitHub CLI (`gh`), Git, and cron.

---

## ⚙️ Features

- 📁 **Create new GitHub repos** directly from your current working folder  
- 🔄 **Clone** any existing repo  
- 🔗 **Merge contents** of one local folder into another  
- ⏱️ **Set up 24h auto-merge** with cron  
- 📤 **Push updates** from your current folder to a GitHub repo  
- 🧠 Smart checks for remotes, auth, repo status, and git init  
- 💡 Clean terminal UI for fast decision-making  

---

## 🚀 Install

```bash
git clone https://github.com/alphacrypt-sun/ezgit.git
cd ezgit
chmod +x github-cli-menu.sh


🧪 Requirements
gh (GitHub CLI) – Install Guide

git

cron (for auto-merge feature)

Unix-based OS (macOS, Linux, WSL, etc.)
🖥️ Usage
Run from any terminal inside your working folder:

bash
Copy
Edit
./github-cli-menu.sh
🧭 Menu Options
sql
Copy
Edit

🔧 GitHub CLI Project Menu
==========================
1. Create new GitHub repo from current folder
2. Clone existing repo
3. Merge one folder into another
4. Set up Watch & Auto-Merge (every 24h)
5. Update & Push Local Repo to GitHub
6. Exit
📌 Behavior Notes
Always uses your current working directory

Handles:

Empty or existing git repos

Missing remotes or setup steps

GitHub CLI auth fallback

Auto-merge logs go to: ~/auto-merge.log

🔒 Defaults
New GitHub repos are created as private

You can override during setup (public)

Repo name is manually entered at creation

🛠️ Future Ideas
 Auto-detect repo name from folder

 .env support for default configs

 GitHub topics or project metadata options

📄 License
MIT – automate responsibly. Just don’t claim you wrote it from scratch.
