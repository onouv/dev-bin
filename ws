#!/bin/bash
source ~/bin-src/wshelp

if [ -z $1 ]; then
  show_help
  exit 0
fi
# set up the secrets for use in ws clip if we are not in a session.
# If we are in ws session, the secrets have been setup already
if ! { [ -n "$TMUX" ] && [ "$TERM" = "screen" ]; }; then
  export DOCKERHUB_TOKEN=$(pass registries/dockerhub/tokens/build)
  export DOCKERHUB_USER=rabaul
  export DOCKERHUB_USER_PASSW=$(pass registries/dockerhub/rabaul)
  export GITHUB_SSH_PASSW=$(pass repos/github/ssh/vivo_20240212_ed25519)
  export GITHUB_CLI_TOKEN="$(pass repos/github/token)"
  export GITHUB_USER=onouv
  export GITHUB_USER_PASSW=$(pass repos/github/onouv)
fi

first=$1
shift

if ! [ -z $first ]; then
  if [[ $first == up ]]; then
    ~/bin-src/wsup $*
  elif [[ $first == down ]]; then
    ~/bin-src/wsdown $*
  elif [[ $first == clip ]]; then
    ~/bin-src/clip $*
  elif [[ $first == exit ]]; then
    tmux detach
  fi
else
  show_help
fi
