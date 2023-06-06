# dotfiles

## setup neovim

todo

## setup prompt shell

- both starship and oh-my-posh are configured, add either to `.bashrc`:

```bash
# run starship prompt shell
eval "$(starship init bash)"

# or

# run oh my posh prompt shell
eval "$(oh-my-posh init bash --config '~/.config/oh-my-posh.omp.json')"
# replace `~` with .config file path
```

- for cmd, add `./oh-my-posh.lua` to the clink scripts directory
- for powershell, add the following line to your `$PROFILE` (`Microsoft.PowerShell_profile.ps1`):

```powershell
# STARSHIP CONFIG
# $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
# # $ENV:STARSHIP_DISTRO = "➜ xcad"
# Invoke-Expression (&starship init powershell)

# or

# OH MY POSH CONFIG
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh.omp.json" | Invoke-Expression
# & ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))

```
