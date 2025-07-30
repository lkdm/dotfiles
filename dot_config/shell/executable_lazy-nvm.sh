#!/usr/bin/env bash

# lazy lode nvm instead of through oh-my-zsh to reduce load by 50%
# https://dev.to/ababber/how-i-improved-my-shell-load-time-with-a-lazy-load-37he
lazy-nvm()
{
  unset -f nvm node npm npx
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

nvm()
{
  lazy-nvm
  nvm $@
}

node()
{
  lazy-nvm
  node $@
}

npm()
{
  lazy-nvm
  npm $@
}

npx()
{
  lazy-nvm
  npx $@
}
