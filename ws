#!/bin/bash
function show_help() {
  echo "Usage: ws up [options] | down [workspace] | clip (git (ssh  | user) | docker (token | <user>))"
  echo "ws"
  echo " . clip"
  echo "   - git"
  echo "     - ssh              ssh password for github access token to clipboard"
  echo "     - user             github user password to clipboard"
  echo "   - docker"
  echo "     - token            dockerhub access token to clipboard"
  echo "     - user             dockerhub user password to clipboard"
  echo " . up                   start a tmux workspace"
  echo "   . -k                 ... with a k8s cluster active"
  echo "     - <namespace>          ... set kubectl namespace, otherwise 'default'"
  echo "   . help               help text"
  echo " . down                  shut down tmux workspace"
  echo "  . <workspace>         ... with given name"
  echo "-----------------------------------------------------------------------------------------"
  echo "Note:  '.' optional alternative parameter, '-' mandatory alternative parameters, <> user-defined text"
}

# set up the secrets for use in ws clip if we are not in a session.
# If we are in ws session, the secrets have been setup already
if ! { [ -n "$TMUX" ] && [ "$TERM" = "screen" ]; }; then
  export DOCKERHUB_TOKEN=W$(pass registries/dockerhub/tokens/build)
  export DOCKERHUB_USER=rabaul
  export GITHUB_SSH_PASSW=$(pass repos/github/ssh/vivo_20240212_ed25519)
  export GITHUB_CLI_TOKEN="$(pass repos/github/token)"
  export GITHUB_USER=onouv
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
  fi
else
  show_help
fi
