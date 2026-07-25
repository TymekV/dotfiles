# config.nu
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings,
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# Load Zoxide
source ~/.zoxide.nu

# Load configuration
source "aliases.nu"
source "title.nu"
source "completions.nu"
source "themes/catppuccin_mocha.nu"

$env.config.edit_mode = 'vi'
$env.config.cursor_shape = {
    vi_insert: line
    vi_normal: block
}
# $env.config.color_config = {
#     shape_garbage: { fg: "#f38ba8" attr: b }
#     shape_external: { fg: "#f38ba8" attr: b }
#     # shape_external_resolved: "green"
#     # shape_internalcall: "green"
# }
$env.config.color_config.shape_garbage = { fg: $theme.red attr: b }
$env.config.color_config.shape_external = { fg: $theme.red attr: b }
$env.config.highlight_resolved_externals = true
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.config.show_banner = false
$env.config.history = {
    file_format: "sqlite"
    max_size: 100000
    sync_on_enter: true
    isolation: true
    # ignore_space_prefixed: true
}
$env.config.completions = {
    external: {
        enable: true
        completer: $fish_completer
    }
}

# Load Starship
nu-mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
