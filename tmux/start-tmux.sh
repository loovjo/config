export LC_ALL="en_US.UTF-8"
export LC_CTYPE="UTF-8"

SESSIONS=$(/opt/homebrew/bin/tmux ls)
SESSIONS="$SESSIONS
Connect to coral.shoes (tmux)
Connect to coral.shoes (raw)
New session
Raw shell"

CHOICE_LINE=$(echo "$SESSIONS" | /opt/homebrew/bin/fzf -1) || exit
CHOICE=$(echo "$CHOICE_LINE" | cut -d: -f1)
case $CHOICE in
    "Connect to coral.shoes (tmux)")
        /opt/homebrew/bin/mosh --ssh="ssh -p 44" web@coral.shoes -- tmux attach
        ;;
    "Connect to coral.shoes (raw)")
        /opt/homebrew/bin/mosh --ssh="ssh -p 44" web@coral.shoes
        ;;
    "Raw shell")
        /bin/zsh
        ;;
    "New session")
        printf "Name? " ; read NAME
        /opt/homebrew/bin/tmux new -s "$NAME" arch -arm64 zsh
        ;;
    *)
        /opt/homebrew/bin/tmux attach-session -t "$CHOICE"
        ;;
esac

