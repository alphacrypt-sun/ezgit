# ezgit.sh

**ezgit.sh** is a simple, interactive Bash script that streamlines common Git and GitHub operations for your projects. Run it from any project directory to quickly create repos, push, pull, clone, merge folders, and more—all from a friendly menu.

## Features

- **Create new GitHub repo** from the current folder (auto-detects name)
- **Push local changes** to GitHub (auto-detects remote or prompts)
- **Pull latest changes** from GitHub (auto-detects remote or prompts)
- **Clone existing repo** by URL
- **Merge one folder into another**
- **Set up Watch & Auto-Merge** (every 24h using cron)
- **Smart detection** of current repo/folder context
- **No need to memorize Git commands!**

## Usage

1. Place `ezgit.sh` in your project folder or add it to your `$PATH`.
2. Make it executable:  
   ```bash
   chmod +x ezgit.sh
   ```
3. Run it from your project directory:  
   ```bash
   ./ezgit.sh
   ```
4. Follow the menu prompts to perform Git/GitHub actions.

## Requirements

- [git](https://git-scm.com/) (installed and in PATH)
- [GitHub CLI (`gh`)](https://cli.github.com/) (installed and authenticated)
- Bash shell

## Menu Overview

```
1. Create new GitHub repo from current folder
2. Push local changes to GitHub
3. Pull latest changes from GitHub
4. Clone existing repo
5. Merge one folder into another
6. Set up Watch & Auto-Merge (every 24h)
7. Exit
```

## Notes

- The script auto-detects your folder/repo context when possible.
- For push/pull, it uses the local `origin` remote; if none exists, you'll be prompted.
- For "Create repo", it checks if the repo already exists on GitHub and offers to push instead of failing.
- "Watch & Auto-Merge" sets up a cron job to copy files every 24 hours.

## Disclaimer

This script is provided as-is. Use at your own risk! Always review changes before pushing to production repositories.

---

Happy coding! 🚀
