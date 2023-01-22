if [ -f ~/.zshrc ] && [ "$LOADED_ZSHRC" != "true" ] ; then
  . ~/.zshrc
fi

##
# Your previous /Users/yammer/.zprofile file was backed up as /Users/yammer/.zprofile.macports-saved_2022-12-02_at_04:51:21
##

# MacPorts Installer addition on 2022-12-02_at_04:51:21: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

