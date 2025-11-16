# NixOS Configuration

Personal NixOS configuration using flakes and home-manager for declarative system and user environment management.

## Overview

This repository contains my complete NixOS system configuration, including:
- Multi-host system configuration with flakes (desktop + homeserver)
- User environment managed by home-manager
- Tiling window manager (XMonad) with Polybar status bar
- Development environment with LSP-enabled Neovim
- Terminal multiplexing with tmux
- Modern shell tools and application launcher (Rofi)
- Infrastructure as Code tools (Docker, Terraform, Ansible)
- Automated disk partitioning with Disko

## Structure

```
nixos/
├── flake.nix                    # Main flake configuration
├── flake.lock                   # Dependency lock file
├── hosts/
│   ├── spaceship/               # Desktop workstation
│   │   ├── configuration.nix    # System configuration
│   │   └── hardware-configuration.nix
│   └── homeserver/              # Home server
│       ├── configuration.nix    # Server configuration
│       ├── hardware-configuration.nix
│       ├── disko.nix            # Disk partitioning
│       └── services/
│           └── docker.nix       # Docker services
└── home/
    ├── home.nix                 # Main home-manager configuration
    ├── desktop/                 # Desktop environment configs
    │   ├── xmonad.nix           # XMonad window manager
    │   ├── xmonad/xmonad.hs     # XMonad Haskell config
    │   └── polybar.nix          # Status bar
    ├── assets/                  # Icons and resources
    │   └── icons/
    └── programs/                # Application configurations
        ├── alacritty.nix        # Terminal emulator
        ├── git.nix              # Git settings and aliases
        ├── nvim.nix             # Neovim with LSP setup
        ├── rofi.nix             # Application launcher
        ├── ssh.nix              # SSH client configuration
        ├── starship.nix         # Shell prompt
        ├── tmux.nix             # Terminal multiplexer
        ├── virt-manager.nix     # Virtualization tools
        └── zsh.nix              # Shell configuration
```

## Quick Start

### For New Installations

1. **Install NixOS** with the standard installer
2. **Clone this repository:**
   ```bash
   git clone https://github.com/houckm/nixos-config.git ~/nixos
   cd ~/nixos
   ```
3. **Update hardware configuration:**
   ```bash
   # Generate hardware config for your system
   sudo nixos-generate-config --show-hardware-config > hosts/spaceship/hardware-configuration.nix
   ```
4. **Review and adjust configuration** in `hosts/spaceship/configuration.nix`
5. **Apply the configuration:**
   ```bash
   # For spaceship (desktop)
   sudo nixos-rebuild switch --flake .#spaceship

   # For homeserver
   sudo nixos-rebuild switch --flake .#homeserver
   ```

### For Existing Systems

1. **Clone the repository:**
   ```bash
   git clone https://github.com/houckm/nixos-config.git ~/nixos
   ```
2. **Apply system configuration:**
   ```bash
   sudo nixos-rebuild switch --flake ~/nixos#spaceship
   # or
   sudo nixos-rebuild switch --flake ~/nixos#homeserver
   ```

   Note: Home-manager is integrated into the system configuration, so no separate home-manager switch is needed.

## Configured Applications

### Development Environment
- **Neovim**: LSP-enabled editor with plugins for:
  - Telescope (fuzzy finding)
  - Treesitter (syntax highlighting)
  - LSP support for Nix, Python, TypeScript, Rust, Haskell, YAML
  - Git integration with Gitsigns and Fugitive
  - File tree navigation
  - Auto-completion and snippets
- **Claude Code**: AI-powered coding assistant
- **Language Tooling**: nil (Nix LSP), yaml-language-server, haskell-language-server
- **Compilers & Build Tools**: GCC, Clang, CMake, GDB, Cabal

### Infrastructure & DevOps
- **Docker**: Container runtime with docker-compose
- **Kubernetes**: kubectl for cluster management
- **Terraform**: Infrastructure as Code
- **Ansible**: Configuration management
- **Network Tools**: nmap, tcpdump, wireshark, iperf3

### Shell Environment
- **Zsh**: Enhanced shell with Oh My Zsh
- **Starship**: Modern, fast shell prompt
- **Tmux**: Terminal multiplexer with Nord theme
  - Session persistence (resurrect/continuum)
  - Vim-style keybindings
  - Tmuxinator for session management
  - FZF integration
- **Modern CLI Tools**: bat, eza, ripgrep, fd, fzf, zoxide, ranger

### Terminal & Desktop
- **Alacritty**: GPU-accelerated terminal emulator
- **XMonad**: Tiling window manager with custom Haskell configuration
- **Polybar**: Status bar with system information
- **Rofi**: Application launcher with Nord theme and icon support
- **Git**: Configured with Delta for better diffs
- **XDG Desktop Entries**: Custom web app launchers for Claude, YouTube, O'Reilly, Reddit, Gmail

### System Tools
- **SSH**: Client configuration with agent setup and authorized keys
- **Virtualization**: virt-manager for VM management
- **System Monitoring**: btop, fastfetch
- **Browsers**: Firefox, Google Chrome
- **Media**: VLC, OBS Studio
- **Communication**: Discord
- **Torrents**: qBittorrent

## Key Features

### Unified Nord Theme
The configuration uses the Nord color scheme consistently across:
- Tmux status bar and panes
- Rofi application launcher
- Polybar status bar
- Terminal colors (Alacritty)

### Aliases and Shortcuts
- `switch` - Rebuild NixOS system configuration
- `v`, `vi`, `vim` - All launch Neovim
- `gs`, `ga`, `gc`, `gp`, `gl` - Git shortcuts

### Neovim Keybindings
- **Leader key**: Space
- `<Space>ff` - Find files (Telescope)
- `<Space>fg` - Live grep in files
- `<Space>e` - Toggle file tree
- `gd` - Go to definition (LSP)
- `K` - Show documentation (LSP)
- `<Space>ca` - Code actions (LSP)

### Tmux Keybindings
- **Prefix key**: Ctrl-b (default)
- `prefix + h/j/k/l` - Navigate panes (vim-style)
- `prefix + H/J/K/L` - Resize panes
- `Alt + Arrow` - Navigate panes without prefix
- `prefix + c` - New window (in current path)
- `prefix + r` - Reload configuration
- `Ctrl-f` - Tmux FZF launcher
- **Vi mode**: Copy mode uses vi keybindings

## Hosts

### Spaceship (Desktop Workstation)
- Full desktop environment with XMonad, Polybar, and Rofi
- Development tools and IDEs
- Multimedia applications
- Home-manager integration for user environment
- Virtualization support

### Homeserver
- Headless server configuration
- Static IP configuration (192.168.1.103)
- Docker and container services
- Automated disk partitioning with Disko
- SSH-only access with key-based authentication
- No home-manager (minimal user environment)
- Automatic garbage collection and store optimization

## Customization

### Adding New Programs
1. Create a new `.nix` file in `home/programs/` (for applications) or `home/desktop/` (for desktop environment)
2. Add the import to `home/home.nix`
3. Rebuild with `sudo nixos-rebuild switch --flake .#spaceship`

### System-Level Changes
1. Edit `hosts/spaceship/configuration.nix` or `hosts/homeserver/configuration.nix`
2. Rebuild with `sudo nixos-rebuild switch --flake .#<hostname>`

### Adding a New Host
1. Create a new directory under `hosts/<hostname>/`
2. Add `configuration.nix` and `hardware-configuration.nix`
3. Add the host to `flake.nix` in `nixosConfigurations`
4. Optionally add host-specific services in `hosts/<hostname>/services/`

### Managing Secrets
Currently using plaintext configuration. Consider implementing:
- `agenix` for encrypted secrets
- `sops-nix` for secret management

### Theme Customization
To change from Nord theme:
- Update colors in `home/programs/tmux.nix`
- Update theme in `home/programs/rofi.nix`
- Update `home/desktop/polybar.nix`
- Update Alacritty colors in `home/programs/alacritty.nix`

## Maintenance

### Updating the System
```bash
# Update flake inputs
nix flake update

# Rebuild system (spaceship)
sudo nixos-rebuild switch --flake .#spaceship

# Rebuild homeserver
sudo nixos-rebuild switch --flake .#homeserver

# Clean old generations
sudo nix-collect-garbage -d
```

### Remote Management (Homeserver)
```bash
# Deploy to homeserver from another machine
nixos-rebuild switch --flake .#homeserver --target-host hunter@192.168.1.103 --build-host localhost --use-remote-sudo
```

### Backing Up
This entire configuration is version-controlled. Additional backups of:
- `/etc/nixos/` (if any manual changes exist)
- Personal data in home directory

## Notes

- **Hardware Configuration**: The `hardware-configuration.nix` file is specific to my hardware. You'll need to generate your own.
- **User Name**: Configuration assumes username `hunter`. Update accordingly if different.
- **Flake Compatibility**: This configuration uses flakes and requires Nix with flakes enabled.

## Dependencies

This configuration uses the following flake inputs:
- **nixpkgs**: NixOS unstable channel
- **home-manager**: User environment management
- **claude-code**: AI-powered coding assistant (https://github.com/sadjow/claude-code-nix)
- **disko**: Declarative disk partitioning (used by homeserver)

Requirements:
- NixOS with flakes enabled
- Git for repository management

## License

This configuration is provided as-is for reference. Feel free to use and modify for your own systems.

## Contributing

This is a personal configuration, but suggestions and improvements are welcome via issues or pull requests.
