# GitHub CLI Menu – GitHub Automation Bash Script

**Version:** 1.3  
**Updated:** May 5, 2025

A simple, interactive Bash CLI tool to automate common GitHub and folder management tasks—ideal for developers who want to streamline project setup, repo management, and folder syncing on Unix-like systems.

---

## Features

- **Create new GitHub repo** from the current folder (with initial commit)
- **Clone existing GitHub repo**
- **Merge contents** from one folder into another
- **Set up automatic folder merge** (every 24h) via cron
- **Update & push** local repo changes to GitHub
- Simple, menu-driven interface with emoji feedback

---

## Requirements

- [GitHub CLI (`gh`)](https://cli.github.com/) (must be authenticated)
- `git`
- `cron`
- Unix-like OS (Linux, macOS, WSL, etc.)
- Bash shell

---

## Installation

1. **Copy the Script**

   Save the following script as `github-cli-menu.sh`:

   ```bash
   #!/bin/bash
   # (script code here, as provided in the repo)
   ```

2. **Make Executable**

   ```sh
   chmod +x github-cli-menu.sh
   ```

3. **(Optional) Add to PATH**

   For global usage, move it to a directory in your `PATH` (e.g., `/usr/local/bin`):

   ```sh
   sudo mv github-cli-menu.sh /usr/local/bin/github-cli-menu
   ```

---

## Usage

Simply run:

```sh
./github-cli-menu.sh
```
or (if installed globally):

```sh
github-cli-menu
```

You'll see the menu:

```
🔧 GitHub CLI Project Menu
===========================
1. Create new GitHub repo from current folder
2. Clone existing repo
3. Merge one folder into another
4. Set up Watch & Auto-Merge (every 24h)
5. Update & Push Local Repo to GitHub
6. Exit
```

Enter a number (1-6) and follow the prompts.

---

## Menu Options Explained

### 1. Create new GitHub repo from current folder
- Initializes Git, makes initial commit, and creates a new private/public repo under your GitHub account using the GitHub CLI.
- **Requires:** Authenticated `gh` CLI.

### 2. Clone existing repo
- Prompts for a GitHub repo URL and clones it into the current directory.

### 3. Merge one folder into another
- Prompts for source and target folder paths (absolute).
- Copies all files from source to target.

### 4. Set up Watch & Auto-Merge (every 24h)
- Sets a cron job to copy (merge) contents from a watched folder to a target folder every 24 hours.
- Logs output to `~/auto-merge.log`.

### 5. Update & Push Local Repo to GitHub
- Adds, commits, and pushes all local changes to the `main` branch of the remote repo.
- If no remote exists, prompts for a repo URL.

### 6. Exit
- Quits the script.

---

## Global Usage (System-wide Setup)

To make the script globally accessible (as `github-cli-menu`):

1. Move the script as root:
   ```sh
   sudo mv github-cli-menu.sh /usr/local/bin/github-cli-menu
   sudo chmod +x /usr/local/bin/github-cli-menu
   ```

2. Now you can call it from anywhere:
   ```sh
   github-cli-menu
   ```

---

## Notes & Tips

- **GitHub CLI Authentication:**  
  Make sure to run `gh auth login` before using repo creation features.
- **Cron Permission:**  
  Ensure your user has permission to add cron jobs. Use `crontab -l` to view or edit.
- **Absolute Paths:**  
  For folder operations, always use absolute paths to avoid errors.
- **Error Handling:**  
  The script provides feedback for invalid inputs and missing directories.

---

## License

MIT License

---

## Contributors

- [Your Name](https://github.com/your-github-profile)

---

## Troubleshooting

- **gh: command not found**  
  → [Install GitHub CLI](https://cli.github.com/manual/installation)
- **Permission denied**  
  → Use `chmod +x github-cli-menu.sh` to make the script executable.
- **cron issues**
  → Check `~/auto-merge.log` for errors or use `crontab -e` to manage scheduled jobs.

---

Enjoy streamlined GitHub automation from your terminal! 🚀
