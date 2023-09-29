# dotfiles

## setup prompt shell

A config file to both [starship](https://starship.rs/installing) and [oh-my-posh](https://ohmyposh.dev/docs/) is made. Add it to:

- for bash, add the following to `.bashrc`

```bash
# run starship prompt shell
eval "$(starship init bash)"

# or

# run oh my posh prompt shell
eval "$(oh-my-posh init bash --config '~/.config/oh-my-posh.omp.json')"
# replace `~` with .config file path
```

## yes, for windows

- for cmd, add `./oh-my-posh.lua` or `./starship.lua` to the [clink](https://chrisant996.github.io/clink/clink.html) scripts directory
- for powershell, add the following line to your `$PROFILE` (`Microsoft.PowerShell_profile.ps1`):

```powershell
# STARSHIP CONFIG
# $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
# # $ENV:STARSHIP_DISTRO = "➜ xcad"
# Invoke-Expression (&starship init powershell)

# or

# OH MY POSH CONFIG
oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh.omp.json" | Invoke-Expression
```
