# Nushell Environment Config File

def create_left_prompt [] {
    ~/Documents/Projekt/Programmering/Rust/unambig-path/target/release/unambig-path | lolcat
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%R %Y-%m-%d')
    ] | str collect)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = { "〉" }
let-env PROMPT_INDICATOR_VI_INSERT = { ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = { "〉" }
let-env PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) }
    to_string: { |v| $v | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:

# Set up PATH
let-env PATH = (
    $env.PATH
  | append $"/opt/homebrew/bin/"
  | append $"/opt/riscv/bin/"
  | append $"/Applications/j903/bin"
  | append $"($env.HOME)/Sage"
  | append $"($env.HOME)/Documents/SelfCompile/binary-links"
  | append $"($env.HOME)/Documents/Commands/"
  | append $"($env.HOME)/Documents/configs/tmux"
  | append $"($env.HOME)/selfcompile-big/binary-links"
  | append $"($env.HOME)/.ghcup/bin"
  # | append $"($env.HOME)/miniforge3/bin"
  | append $"($env.HOME)/Library/Python/3.8/bin"

  | append "/opt/homebrew/opt/llvm/bin"
)

let-env PKG_CONFIG_PATH = "/opt/unicorn/lib"


# Aliai

alias py = python
alias ipy = ipython
alias c = cargo
alias bqn = rlwrap BQN

# Run keybinds
# TODO: This should be done at startup lol

sh '~/Documents/kblayouts/keybind.sh'

def project [prefix?: string] {
    let $prefix = if $prefix == null { "" } else { $prefix }

    cd ~/Documents/A-Aktivta

    let $path = (fd '' -t l -d 1 --full-path . | fzf -1 -q $prefix | str trim -r)

    $path | path expand
}

alias pr = cd (project)
