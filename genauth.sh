#!/usr/bin/env bash

>&2 echo 'Save the output of this script to .env or'
>&2 echo 'to export the auth info to the environment, run: eval $(sh genauth.sh | awk '"'"'{ print "export", $1}'"'"')'

read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) >&2 echo "ok";;
  n|N ) exit 1;;
  * ) exit 2;;
esac

ADMIN=admin
USER=user

>&2 echo "Set admin password:"
ADMIN_PASS=$(openssl passwd -apr1)

>&2 echo "Set user password:"
USER_PASS=$(openssl passwd -apr1)

if [ -t 1 ] ; then
    echo "export ADMIN_BASIC_AUTH='$ADMIN:$ADMIN_PASS'"
    echo "export USER_BASIC_AUTH='$USER:$USER_PASS'"
  else
    echo "ADMIN_BASIC_AUTH='$ADMIN:$ADMIN_PASS'"
    echo "USER_BASIC_AUTH='$USER:$USER_PASS'"
  fi
