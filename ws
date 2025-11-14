#!/bin/bash
first=$1
shift
if ! [ -z $first ]; then
  if [[ $first == up ]]; then
    wsup $*
  elif [[ $first == down ]]; then
    wsdown $*
  elif [[ $first == clip ]]; then
    second=$1
    if ! [ -z $second ]; then
      if [[ $second == git ]]; then
        gitclip
      elif [[ $second == docker ]]; then
        dockerclip
      fi
    fi
  elif [[ $first == help ]]; then
    wsup --help
  fi
else
  echo "Usage: ws up [options] | down [workspace] | clip (git | docker) | help"
fi
