function pcodex
    set -lx CODEX_HOME (pwd)/.codex
    codex $argv
end
