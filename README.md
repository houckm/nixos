# NixOS Configuration

Personal NixOS configuration using flakes and home-manager for declarative system and user environment management.

## Overview

This repository contains my complete NixOS system configuration, including:
- System-level configuration with flakes
- User environment managed by home-manager
- Window manager setup (XMonad)
- Development environment with LSP-enabled Neovim
- Terminal and shell configuration

## Structure

```
nixos-config/
├── flake.nix                    # Main flake configuration
├── flake.lock                   # Dependency lock file
├── hosts/
│   └── spaceship/
│       ├── configuration.nix    # System configuration
│       └── hardware-configuration.nix  # Hardware-specific settings
└── home/
    ├── hunter.nix              # Main home-manager configuration
    └── programs/               # Application configurations
        ├── alacritty.nix       # Terminal emulator
        ├── emacs.nix           # Emacs configuration
        ├── git.nix             # Git settings and aliases
        ├── nvim.nix            # Neovim with LSP setup
        ├── ssh.nix             # SSH client configuration
        ├── starship.nix        # Shell prompt
        ├── virt-manager.nix    # Virtualization tools
        └── zsh.nix             # Shell configuration
```

## Quick Start

### For New Installations

1. **Install NixOS** with the standard installer
2. **Clone this repository:**
   ```bash
   git clone https://github.com/houckm/nixos-config.git ~/nixos-config
   cd ~/nixos-config
   ```
3. **Update hardware configuration:**
   ```bash
   # Generate hardware config for your system
   sudo nixos-generate-config --show-hardware-config > hosts/spaceship/hardware-configuration.nix
   ```
4. **Review and adjust configuration** in `hosts/spaceship/configuration.nix`
5. **Apply the configuration:**
   ```bash
   sudo nixos-rebuild switch --flake ~/nixos-config
   ```

### For Existing Systems

1. **Clone the repository:**
   ```bash
   git clone https://github.com/houckm/nixos-config.git ~/nixos-config
   ```
2. **Apply system configuration:**
   ```bash
   sudo nixos-rebuild switch --flake ~/nixos-config
   ```
3. **Apply home-manager configuration:**
   ```bash
   home-manager switch --flake ~/nixos-config
   ```

## Configured Applications

### Development Environment
- **Neovim**: LSP-enabled editor with plugins for:
  - Telescope (fuzzy finding)
  - Treesitter (syntax highlighting)
  - LSP support for Nix, Python, TypeScript, Rust
  - Git integration with Gitsigns and Fugitive
  - File tree navigation
  - Auto-completion and snippets

### Shell Environment
- **Zsh**: Enhanced shell with Oh My Zsh
- **Starship**: Modern, fast shell prompt
- **Useful aliases**: Git shortcuts, system rebuild commands

### Terminal & Desktop
- **Alacritty**: GPU-accelerated terminal emulator
- **XMonad**: Tiling window manager
- **Git**: Configured with Delta for better diffs

### System Tools
- **SSH**: Client configuration with agent setup
- **Development tools**: Language servers, compilers, formatters

## Key Features

### Aliases and Shortcuts
- `nrs` - Rebuild NixOS system configuration
- `hms` - Rebuild home-manager configuration  
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

## Hardware Requirements

This configuration is set up for my specific hardware. Key considerations:
- Uses XMonad window manager
- Configured for standard PC hardware
- Includes virtualization support

## Customization

### Adding New Programs
1. Create a new `.nix` file in `home/programs/`
2. Add the import to `home/hunter.nix`
3. Rebuild with `hms`

### System-Level Changes
1. Edit `hosts/spaceship/configuration.nix`
2. Rebuild with `nrs`

### Managing Secrets
Currently using plaintext configuration. Consider implementing:
- `agenix` for encrypted secrets
- `sops-nix` for secret management

## Maintenance

### Updating the System
```bash
# Update flake inputs
nix flake update

# Rebuild system
nrs

# Clean old generations
sudo nix-collect-garbage -d
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

- NixOS 23.05+ (unstable channel recommended)
- Nix with flakes enabled
- Git for repository management

## License

This configuration is provided as-is for reference. Feel free to use and modify for your own systems.

## Contributing

This is a personal configuration, but suggestions and improvements are welcome via issues or pull requests.
