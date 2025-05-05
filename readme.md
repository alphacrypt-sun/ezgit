# 📘 `github-cli-menu.sh` – GitHub Automation CLI

A no-BS Bash script that simplifies daily GitHub project tasks — creating, cloning, merging, and watching repositories — all from a terminal menu. Powered by GitHub CLI (`gh`), Git, and cron.

---

## ⚙️ Features

- 📁 Create new GitHub repos directly from any local folder  
- 🔄 Clone existing repos  
- 🔗 Merge contents of one repo/folder into another  
- ⏱️ Set up automated 24h watch & auto-merge between folders  
- 💡 Clean terminal menu UI with interactive prompts  
- 🧠 Smart fallback handling (missing remotes, empty commits, auth status, etc.)

---

## 🚀 Install

1. **Clone or download the script**
   ```bash
   git clone https://github.com/alphacrypt-sun/ezgit.git
   cd <repo-name>
   chmod +x github-cli-menu.sh
   ```

---

## 🧪 Requirements

- `gh` (GitHub CLI) – [Install Guide](https://cli.github.com/)  
- `git`  
- `cron` (for auto-merge feature)  
- Unix-based OS (macOS, Linux, WSL, etc.)

---

## 🖥️ Usage

Run directly:
```bash
./github-cli-menu.sh
```

Or globally (if symlinked):
```bash
ghmenu
```

### Menu:
```
🔧 GitHub CLI Project Menu
==========================
1. Create new GitHub repo from folder
2. Clone existing repo
3. Merge one folder into another
4. Set up Watch & Auto-Merge (every 24h)
5. Exit
```

---

## 📌 Notes

- You do **not** need to be inside the project folder to run it
- Accepts full or `~/`-based paths
- Handles:
  - Existing Git repos
  - Auth via GitHub CLI
  - Auto merge errors cleanly (with fallback)
- Logs auto-merge results to `~/auto-merge.log`

---

## 🔒 Visibility Defaults

- New repos are created as **private** by default  
- You can override by entering `public` during setup prompt

---

## 🛠️ To-Do

- Add a `--help` CLI flag  
- Auto-suggest repo name from folder name  
- Add optional `.env` support  
- Enable GitHub topics / license templates via `gh repo edit`

---

## 📄 License

MIT – do whatever, just don’t be a jerk about it.
