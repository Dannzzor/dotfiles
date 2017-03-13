[ -n "$PS1" ] && source ~/.bash_profile;

# Added by the canvas-lms setup script
# These settings make chruby work
# See https://github.com/postmodern/chruby
[ -f /usr/local/share/chruby/chruby.sh ] && . /usr/local/share/chruby/chruby.sh
[ -f /usr/local/share/chruby/auto.sh ] && . /usr/local/share/chruby/auto.sh
[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ] && . /usr/local/opt/chruby/share/chruby/chruby.sh
[ -f /usr/local/opt/chruby/share/chruby/auto.sh ] && . /usr/local/opt/chruby/share/chruby/auto.sh
