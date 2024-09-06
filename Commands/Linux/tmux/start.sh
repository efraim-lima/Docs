#!/bin/bash

# Set the session name
SESSION_NAME="Teminal Padrão"
$PSWD="37137"

# Check if the TMUX environment variable is set
if [ -z "$TMUX" ]; then
    # Check if the session already exists
    if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        cd ~ 
        # Create a new session
        tmux new-session -d -s "$SESSION_NAME"

        # Create the grid layout
        tmux split-window -v
        tmux split-window -h
    tmux split-window -v
        tmux split-window -h
        tmux split-window -v
        tmux split-window -h
        tmux select-layout tiled

        # Run the commands in the first 3 grid positions
        tmux send-keys -t "$SESSION_NAME:0.0" 'ping localhost' C-m
        tmux send-keys -t "$SESSION_NAME:0.1" 'ncdu' C-m
        tmux send-keys -t "$SESSION_NAME:0.2" "ss -HOnrapE | grep -v '0.0.0.0:'" C-m
        #tmux send-keys -t "$SESSION_NAME:0.2" 'sudo watch -n 1 "ss -tunlpE | awk '\''{print \$1, \$2, \$3, \$4, \$5, \$6, \$7}'\''"' C-m
        #tmux send-keys -t "$SESSION_NAME:0.3" 'sudo watch ss -s $PSWD' C-m
        tmux send-keys -t "$SESSION_NAME:0.4" 'iostat -pstxz --pretty 1' C-m
        tmux send-keys -t "$SESSION_NAME:0.5" 'journalctl -fxe' C-m
        tmux send-keys -t "$SESSION_NAME:0.6" 'glances' C-m
    fi

    # Attach to the session
    tmux attach-session -t "$SESSION_NAME"
else
    echo "You are already inside a TMUX session. Please run this script outside of TMUX."
fi
