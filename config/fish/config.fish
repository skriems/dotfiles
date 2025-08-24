setenv SHELL /opt/homebrew/bin/fish

function __nvm_use
    if test -f .nvmrc
        nvm use
    end
end

function __dotenv
    if test -f .env
        source .env
    end
end

# If you want to run this every time, just add this line below to your config.fish
# or create a function that runs the following code and call that in config.fish.
function __oncd --on-variable PWD --description 'Run nvm use when changing directories'
    __nvm_use
    __dotenv
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    # if ! set -q TMUX
    #     exec tmux
    # end
end

if status is-login
    # Commands to run in login shells can go here
    keychain --clear --quiet
end

if test -f $HOME/.keychain/(hostname)-gpg-fish
    source $HOME/.keychain/(hostname)-gpg-fish
end

if test -f $HOME/.keychain/(hostname)-fish
    source $HOME/.keychain/(hostname)-fish
end

# eval $(keychain --eval --quiet --confhost $HOME/.ssh/id_rsa)
# eval $(keychain --eval --quiet --confhost $HOME/.ssh/id_ed25519)

export (grep "^[^#]" $HOME/.config/fish/.env |xargs -L 1)

fish_add_path /usr/local/bin # set -gx PATH $PATH $HOME/.local/bin
fish_add_path /usr/local/sbin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /opt/homebrew/opt/fzf/bin
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.jenv/shims
fish_add_path $HOME/.jenv/bin
fish_add_path /usr/local/opt/coreutils/libexec/gnubin # suggested by $(brew doctor)

setenv EDITOR nvim

eval (/opt/homebrew/bin/brew shellenv)

# setenv JAVA_HOME (jenv javahome)
setenv CARGO_TARGET_DIR $HOME/.cargo/target
setenv NVM_DIR $HOME/.nvm
setenv BAT_CONFIG_DIR $HOME/.config/bat
setenv KUBECONFIG $HOME/sailrs/k3s/fleet-1/fleet-1_kubeconfig.yaml

setenv GITLAB_USER skriems

# setenv GITLAB_TOKEN $(bw get password GITLAB_TOKEN)
# setenv TF_VAR_hcloud_token $(bw get password hcloud_token_sailrs)
# setenv TF_VAR_hcloud_token $(bw get password hcloud_token_playground)

setenv TF_VAR_ssh_private_key $HOME/.ssh/id_terraform
setenv TF_VAR_ssh_public_key $HOME/.ssh/id_terraform.pub

setenv APPLE_SSH_ADD_BEHAVIOR macos # ssh - use '--apple-use-keychain'

setenv FZF_DEFAULT_COMMAND 'rg --files --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
setenv FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

setenv FZF_DEFAULT_OPTS "--no-mouse --height 60% -1 --reverse --multi --inline-info \
--preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || \
(bat --color=always {} || cat {}) 2> /dev/null | head -300' \
--bind='f3:execute(bat {} || less -f {}),f2:toggle-preview,shift-up:preview-page-up,shift-down:preview-page-down,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy)'"

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles yes
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream none
set -g fish_prompt_pwd_dir_length 3

if command -v exa >/dev/null
    abbr -a l exa
    abbr -a ls exa
    abbr -a ll 'exa -l'
    abbr -a lll 'exa -la'
else
    abbr -a l ls
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# load rbenv on startup
status --is-interactive; and rbenv init - fish | source

# fish shell integration
fzf --fish | source


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/skriems/.opam/opam-init/init.fish' && source '/Users/skriems/.opam/opam-init/init.fish' >/dev/null 2>/dev/null; or true
# END opam configuration

set --universal nvm_default_version v22.14.0

ssh-add --apple-use-keychain ~/.ssh/id_ed25519
