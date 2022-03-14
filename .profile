#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#export MOZ_ENABLE_WAYLAND=1
PATH="$HOME/.node_modules/bin:$PATH"
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
PATH="$PATH:$HOME/.bin"
PATH="$PATH:$HOME/.local/bin"
export npm_config_prefix=~/.node_modules
export NPM_TOKEN="ZHV6eUBhd2Vzb21lLWluZC5jb206dzVLQ1VON2Y0YQ=="
# export QT_QPA_PLATFORMTHEME="qt5ct"
export RIPGREP_CONFIG_PATH=~/.ripgreprc

