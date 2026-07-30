# This script parses kubectl output into Nushell structured tables

# https://github.com/nushell/nushell/issues/2749
def kubetable [] { align | lines | str trim | split column ' ' --collapse-empty | headers }
alias "from kubectl" = kubetable
alias kt = kubetable

def "nu-complete kubectl" [context: string] {
    let spans = ($context | split row " ")
    do $env.config.completions.external.completer $spans
}

def "nu-complete k" [context: string] {
    # Dirty hack to replace `k` with `kubectl` for the fish_completer
    let spans = ($context | split row " " | skip)
    do $env.config.completions.external.completer ["kubectl", ...$spans]
}


def into-int-safe [col: string] {
    let t = $in
    if $col in ($t | columns) {
        $t | into int $col
    } else {
        $t
    }
}

def is-upper [c: string] {
    $c == ($c | str uppercase) and $c != ($c | str lowercase)
}

def --wrapped kubectl [...args: string@"nu-complete kubectl"] {
    let result = (^kubectl ...$args)

    if not (is-upper ($result | str substring 0..1)) {
        return $result
    }

    try {
        match $args {
            [get, _, ..$rest] => { $result | kt | into-int-safe RESTARTS }
            [top, _, ..$rest] => { $result | kt }
            _ => $result
        }
    } catch {
        $result
    }
}

# For some reason aliasing `k` didn't work
def --wrapped k [...args: string@"nu-complete k"] {
    kubectl ...$args
}

