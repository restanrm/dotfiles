_sshp_commandname="sshp"

_sshp_servers () {
    local cache
    cache="/$HOME/.cache/${_sshp_commandname}-cache"
    if [ -e "$cache" ] && [ "$(($(date +%s) - $(/sbin/stat -c %Y "$cache")))" -lt "3600" ]; then
        compadd ${(uo)$(cat "$cache")}
    else
        ssh -I /usr/lib/libykcs11.so fra1-production -- --osh groupListServers --group sre 2>/dev/null | awk -F'=' '/hostname/{print $2}' | sort -u > $cache
        compadd ${(uo)$(cat "$cache")}
    fi
}

_sshp() {
    integer ret=1
    _alternative 'servers:servers:_sshp_servers' && ret=0
}

compdef _sshp sshp

_ssht_commandname="ssht"

_ssht_servers () {
    local cache
    cache="/$HOME/.cache/${_ssht_commandname}-cache"
    if [ -e "$cache" ] && [ "$(($(date +%s) - $(/sbin/stat -c %Y "$cache")))" -lt "3600" ]; then
        compadd ${(uo)$(cat "$cache")}
    else
        ssh -I /usr/lib/libykcs11.so fra1-test -- --osh groupListServers --group sre 2>/dev/null | awk -F'=' '/hostname/{print $2}' | sort -u > $cache
        compadd ${(uo)$(cat "$cache")}
    fi
}

_ssht() {
    integer ret=1
    _alternative 'servers:servers:_ssht_servers' && ret=0
}

compdef _ssht ssht
