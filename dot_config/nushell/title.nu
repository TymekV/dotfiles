$env.config.shell_integration.osc2 = false

def title-dir [] {
    if $env.PWD == $env.HOME {
        "~"
    } else {
        let base = ($env.PWD | path basename)

        if $base == "" {
            "/"
        } else {
            $base
        }
    }
}

def title-bin [] {
    let cmd = (commandline | str trim)

    if $cmd == "" {
        ""
    } else {
        $cmd
        | split row " "
        | where {|x| $x != "" }
        | first
        | str replace --regex '^\^' ''
        | path basename
    }
}

$env.config.hooks.pre_prompt = (
    $env.config.hooks.pre_prompt | append {||
        print -n $"(ansi title)(title-dir)(ansi st)"
    }
)

$env.config.hooks.pre_execution = (
    $env.config.hooks.pre_execution | append {||
        let dir = (title-dir)
        let bin = (title-bin)

        if $bin != "" {
            print -n $"(ansi title)($dir) › ($bin)(ansi st)"
        }
    }
)

