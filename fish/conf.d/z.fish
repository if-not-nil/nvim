if test -z "$Z_DATA"
    if test -z "$XDG_DATA_HOME"
        set -U Z_DATA_DIR "$HOME/.local/share/z"
    else
        set -U Z_DATA_DIR "$XDG_DATA_HOME/z"
    end
    set -U Z_DATA "$Z_DATA_DIR/data"
end

if test ! -e "$Z_DATA"
    if test ! -e "$Z_DATA_DIR"
        mkdir -p -m 700 "$Z_DATA_DIR"
    end
    touch "$Z_DATA"
end

if test -z "$Z_CMD"
    set -U Z_CMD z
end

set -U ZO_CMD "$Z_CMD"o

if test ! -z $Z_CMD
    function $Z_CMD -d "jump around"
        __z $argv
    end
end

if test ! -z $ZO_CMD
    function $ZO_CMD -d "open target dir"
        __z -d $argv
    end
end

if not set -q Z_EXCLUDE
    set -U Z_EXCLUDE "^$HOME\$"
else if contains $HOME $Z_EXCLUDE
    # Workaround: migrate old default values to a regex (see #90).
    set Z_EXCLUDE (string replace -r -- "^$HOME\$" '^'$HOME'$$' $Z_EXCLUDE)
end

function __z_complete -d "add completions"
    complete -c $Z_CMD -a "(__z -l | string replace -r '^\\S*\\s*' '')" -f -k
    complete -c $ZO_CMD -a "(__z -l | string replace -r '^\\S*\\s*' '')" -f -k

    complete -c $Z_CMD -s c -l clean -d "Cleans out $Z_DATA"
    complete -c $Z_CMD -s e -l echo -d "Prints best match, no cd"
    complete -c $Z_CMD -s l -l list -d "List matches, no cd"
    complete -c $Z_CMD -s p -l purge -d "Purges $Z_DATA"
    complete -c $Z_CMD -s r -l rank -d "Searches by rank, cd"
    complete -c $Z_CMD -s t -l recent -d "Searches by recency, cd"
    complete -c $Z_CMD -s h -l help -d "Print help"
    complete -c $Z_CMD -s x -l delete -d "Removes the current directory from $Z_DATA"
end
# Setup completions once first
__z_complete

function __z_on_variable_pwd --on-variable PWD
    __z_add
end

function __z_uninstall --on-event z_uninstall
    functions -e __z_on_variable_pwd
    functions -e $Z_CMD
    functions -e $ZO_CMD

    if test ! -z "$Z_DATA"
        printf "To completely erase z's data, remove:\n" >/dev/stderr
        printf "%s\n" "$Z_DATA" >/dev/stderr
    end

    set -e Z_CMD
    set -e ZO_CMD
    set -e Z_DATA
    set -e Z_EXCLUDE
end
