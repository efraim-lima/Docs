unbind r
bind r source-file ~/.tmux.conf

#act like vi
set -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R

#Alterando configuração para Control A
set-option -g prefix C-a
unbind C-b
bind C-a send-prefix

#Adicionando plugins
set -g @plugin "tmux-plugins/tmux-sensible"
set -g @plugin "tmux-plugins/tpm"
set -g @plugin "tmux-plugins/tmux-yank"
set -g @plugin "tmux-plugins/tmux-ressurect"
set -g @plugin "christoomey/vim-tmux-navigator"
set -g @plugin "tmux-plugins/tmux-battery"
set -g @plugin "olimorris/tmux-pomodoro-plus"
set -g @plugin '2kabhishek/tmux2k'

#tmux ressucection strategy
set -g @ressurect-strategy-vim 'session'
set -g @resurrect-save 'C-s'
set -g @resurrect-restore 'C-r'

# set the left and right plugin sections
set -g @tmux2k-theme 'default'
set -g @tmux2k-left-plugins "git cpu ram"
set -g @tmux2k-right-plugins "battery network time"
# to customize plugin colors
#set -g @tmux2k-[plugin-name]-colors "[background] [foreground]"
set -g @tmux2k-cpu-colors "red black" # set cpu plugin bg to red, fg to black
# to enable compact window list size
set -g @tmux2k-compact-windows true
# change refresh rate
set -g @tmux2k-refresh-rate 5
# weather scale
set -g @tmux2k-show-fahrenheit false
# 24 hour time
set -g @tmux2k-military-time true
# network interface to watch
set -g @tmux2k-network-name "wlo1"

run '~/.tmux/plugins/tpm/tpm'
