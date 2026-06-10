# Dotfiles

Personal dotfiles for macOS development environment setup. Includes shell configs, git setup, tmux, neovim, and AI agent standards (Claude Code, Cursor, GitHub Copilot).

## Quick Start: New Machine Setup

### Option 1: Automated (Recommended)

Run the bootstrap script on a fresh machine:

```bash
cd ~/repos/dotfiles
./bootstrap.sh
```

This will:
- ✅ Install Homebrew (if not already installed)
- ✅ Install nvm (Node Version Manager) and Node.js LTS
- ✅ Install all packages from Brewfile
- ✅ Create symlinks for all dotfiles
- ✅ Optionally apply macOS system defaults
- ✅ Optionally set up Neovim

### Option 2: Manual Setup

If you already have Homebrew and nvm installed:

```bash
cd ~/repos/dotfiles
./install_dotfiles.sh
```

Then install packages:

```bash
brew bundle --file=~/repos/dotfiles/Brewfile
```

## File Structure

```
dotfiles/
├── bootstrap.sh                 # One-time fresh machine setup
├── install_dotfiles.sh          # Install symlinks only
├── nvim_settings_install.sh     # Optional: set up Neovim
├── mac_setup.sh                 # Optional: macOS system defaults
├── Brewfile                     # Homebrew packages & casks
│
├── .zshrc                       # Zsh config (primary shell)
├── .aliases                     # Shell aliases
├── .functions                   # Shell functions
├── .exports                     # Environment variables
│
├── .gitconfig                   # Git configuration
├── .gitignore                   # Global git ignore patterns
├── .git_commit_msg.txt          # Git commit message template
│
├── .tmux.conf                   # Tmux configuration
├── .tmux_colors                 # Tmux colors
│
├── .vimrc                       # Vim configuration
├── .inputrc                     # Readline configuration
│
├── .npmrc                       # NPM configuration
├── .eslintrc.json               # ESLint configuration
├── .dircolors                   # Directory colors
│
├── nvim/                        # Neovim configuration
├── iterm-config/                # iTerm2 profiles
│
├── ai/                          # AI Agent Configurations
│   ├── README.md               # AI setup guide
│   ├── STANDARDS.md            # Shared standards for all agents
│   ├── sync-check.sh           # Check for stale configs
│   ├── claude/
│   │   └── CLAUDE.md          # Claude Code rules
│   ├── cursor/
│   │   └── .cursorrules       # Cursor rules
│   └── copilot/
│       └── copilot-instructions.md  # GitHub Copilot rules
│
└── README.md                    # This file
```

## Symlinked Files

After setup, these files are symlinked to your home directory:

### Shell & Development
| File | Link | Purpose |
|------|------|---------|
| `.zshrc` | `~/.zshrc` | Primary shell configuration |
| `.aliases` | `~/.aliases` | Shell command aliases |
| `.functions` | `~/.functions` | Custom shell functions |
| `.exports` | `~/.exports` | Environment variables |
| `.inputrc` | `~/.inputrc` | Readline configuration |

### Git
| File | Link | Purpose |
|------|------|---------|
| `.gitconfig` | `~/.gitconfig` | Git configuration |
| `.gitignore` | `~/.gitignore` | Global ignore patterns |
| `.git_commit_msg.txt` | `~/.git_commit_msg.txt` | Commit message template |

### Editors & Tools
| File | Link | Purpose |
|------|------|---------|
| `.vimrc` | `~/.vimrc` | Vim configuration |
| `.npmrc` | `~/.npmrc` | NPM configuration |
| `.eslintrc.json` | `~/.eslintrc.json` | ESLint configuration |

### Terminal & Tmux
| File | Link | Purpose |
|------|------|---------|
| `.tmux.conf` | `~/.tmux.conf` | Tmux configuration |
| `.tmux_colors` | `~/.tmux_colors` | Tmux color scheme |
| `.dircolors` | `~/.dircolors` | Directory listing colors |

### AI Agent Configurations
| File | Link | Purpose |
|------|------|---------|
| `ai/claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Claude Code rules |
| `ai/cursor/.cursorrules` | `~/.cursorrules` | Cursor rules |
| `ai/copilot/copilot-instructions.md` | `~/.config/github-copilot/instructions.md` | Copilot rules |

### Auto-Created
| File | Purpose |
|------|---------|
| `~/.extra` | Secrets and machine-specific config (NOT committed) |

## Post-Setup Configuration

### Git Commit Template

Enable the commit message template:

```bash
git config --global commit.template ~/.git_commit_msg.txt
```

### Tmux Aliases

Start preset tmux sessions:

```bash
devmux    # Development session with splits
hackmux   # Hacker session with vim + htop
```

### AI Agent Configuration

Review and customize AI agent rules:

- View shared standards: `cat ~/repos/dotfiles/ai/STANDARDS.md`
- Edit Claude rules: `nvim ~/repos/dotfiles/ai/claude/CLAUDE.md`
- Edit Cursor rules: `nvim ~/repos/dotfiles/ai/cursor/.cursorrules`
- Edit Copilot rules: `nvim ~/repos/dotfiles/ai/copilot/copilot-instructions.md`

For more info, see: `~/repos/dotfiles/ai/README.md`

### Check for Stale Configs

After updating AI standards, check which tool configs need refreshing:

```bash
~/repos/dotfiles/ai/sync-check.sh
```

## Package Management

### Adding Packages

Add new packages to Brewfile:

```bash
# Add to Brewfile manually, then run:
brew bundle --file=~/repos/dotfiles/Brewfile
```

### Upgrading Packages

```bash
brew update
brew upgrade
brew bundle --file=~/repos/dotfiles/Brewfile cleanup
```

## Optional Customizations

### Apply macOS Defaults

Run system preference defaults:

```bash
bash ~/repos/dotfiles/mac_setup.sh
```

This customizes Dock, Finder, Spotlight, and other system preferences.

### Set Up Neovim

Configure Neovim after bootstrap:

```bash
bash ~/repos/dotfiles/nvim_settings_install.sh
```

## Machine-Specific Secrets & Config

Create `~/.extra` for secrets and machine-specific config that shouldn't be committed:

```bash
# Example ~/.extra (NOT committed to repo):
export GITHUB_TOKEN="your_token_here"
export AWS_PROFILE="default"
export API_KEY="your_key_here"
```

This file is sourced by `.zshrc` automatically.

Also set your git identity:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Troubleshooting

### Symlinks not created?

Check if they exist:
```bash
ls -la ~/.zshrc ~/.gitconfig ~/.cursorrules
```

Re-run the installer:
```bash
cd ~/repos/dotfiles
./install_dotfiles.sh
```

### Shell not reloading?

Open a new terminal window or reload:
```bash
exec $SHELL -l
```

### Backup files created?

If setup encountered existing files, backups are created with `.bak` extension:
```bash
ls -la ~/*.bak
```

Review and remove if no longer needed.

## Common Tasks

### Edit shell config
```bash
nvim ~/.zshrc
# Or use the alias:
zshconfig
```

### Add a new alias
```bash
nvim ~/repos/dotfiles/.aliases
# Then reload:
source ~/.aliases
```

### Add a custom function
```bash
nvim ~/repos/dotfiles/.functions
# Then reload:
source ~/.functions
```

### Update Brewfile
```bash
brew bundle dump --file=~/repos/dotfiles/Brewfile --force
```

## File Sync Notes

If you edit dotfiles in `~/repos/dotfiles/`, changes take effect immediately since they're symlinked. No need to copy files around.

Changes to `~/.extra` do NOT affect the repo (that's intentional—it's for secrets).

## Contributing

Feel free to customize any files to match your preferences. The `.extra` file is perfect for machine-specific overrides.

---

**Created**: 2026-06-08  
**Last Updated**: 2026-06-08
