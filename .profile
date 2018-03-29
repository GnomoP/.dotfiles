# ~/.profile: executed by Bourne-compatible login shells.
# shellcheck source=/dev/null

if [ "$BASH" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
  fi
fi

mesg n || true
# vim: syntax=sh
# vim: set ts=2 sw=2 tw=80 et :
