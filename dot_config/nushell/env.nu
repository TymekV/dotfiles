# env.nu
#
# Installed by:
# version = "0.106.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.USE_CCACHE = 1
$env.CCACHE_EXEC = "/usr/bin/ccache"
$env.EDITOR = "nvim"
$env.VISUAL = "zed --wait"
$env.config.buffer_editor = "nvim"
$env.PATH ++= [
    ($env.HOME | path join ".local/bin"),
    ($env.HOME | path join ".cargo/bin")
]

source "secrets.nu"

source "themes/fzf_catppuccin_mocha.nu"

source "keybinds.nu"

zoxide init nushell | save -f ~/.zoxide.nu

