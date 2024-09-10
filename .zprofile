if [ -f ~/.zshrc ] && [ "$LOADED_ZSHRC" != "true" ] ; then
  . ~/.zshrc
fi

# Finished adapting your PATH environment variable for use with MacPorts.
if [ -e "/opt/homebrew" ]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi
