export PYENV_ROOT="$PWD"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
