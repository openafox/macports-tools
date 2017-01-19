#!/bin/bash

#Modified from https://gist.github.com/jonlabelle/2938951

# script for daily maintenance of mac ports
# upgrades to packages
# discards orphaned packages, etc.


if [ -n $(which port) ]; then
  echo "port available"

  read -p "Shall I do selfupgrade? [y/N] " ANSWER

  case ${ANSWER} in
    "y" | "Y" )
      echo "running port selfupdate"
      # upgrade system
       sudo port -c selfupdate
      ;;
  esac

  # show outdated ports
  OUTDATED=$(port outdated | grep -v 'No installed ports are outdated.')

  if [ -n "${OUTDATED}" ]; then
    read -p "Shall I oupgrade the outdated ports? [Y/n] " ANSWER
    case ${ANSWER} in
      "" | "y" | "Y" )
        # upgrade system
        sudo port upgrade outdated
        ;;
    esac
  else
    echo "no ports outdated"
    echo "exiting"
  fi

else
  echo " Please install MacPorts https://www.macports.org/install.php"
fi
