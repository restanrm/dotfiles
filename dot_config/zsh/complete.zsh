# Completion for the alias sshp
_sshp() {
    integer ret=1

    # Define function only when it doesn't exist
    (( $+functions[_sshp_cache_policy] )) || _sshp_cache_policy() {
      # Cache invalidates after 1 hour
      #
      # Reference:
      #   https://zsh.sourceforge.net/Doc/Release/Expansion.html#index-globbing_002c-qualifiers
      local -a oldp
      oldp=( "$1"(ms+3600) )
      (( $#oldp ))
    }

    # Unless user explicitly turned off caching, enable caching just for this context
    local existing_setting
    zstyle -s ":completion:${curcontext}:" use-cache existing_setting
    if [[ -z "${existing_setting}" ]]; then
      zstyle ":completion:${curcontext}:" use-cache on
    fi

    # Update cache policy only when there was no existing policy
    local existing_policy
    zstyle -s ":completion:${curcontext}:" cache-policy existing_policy
    if [[ -z "${existing_policy}" ]]; then
      zstyle ":completion:${curcontext}:" cache-policy _sshp_cache_policy
    fi

    local -a instances
    if _cache_invalid sshp_instances || ! _retrieve_cache sshp_instances; then
      local instances
      local stderr
      local -i exit_code
      () {
        ssh -I /usr/lib/libykcs11.so fra1-production -- --osh groupListServers --group sre 2>/dev/null | awk -F'=' '/hostname/{print $2}' | sort -u >${1} 2>${2}
        exit_code=${?}
        IFS=$'\n\t' instances=($(<${1}))
        stderr=$(<${2})
      } =(:) =(:)

      if (( $exit_code == 0 )); then
        # Bastion CLI successfully executed
        _store_cache sshp_instances instances
      else
        # Bastion CLI failed, abort autocompletion
        _message -r "\
    Failed autocomplete due to following reason:
    ${stderr}"
        return
      fi
    fi
    _describe 'command' instances
}
compdef _sshp sshp

# Completion for the alias ssht
_ssht() {
    integer ret=1

    # Define function only when it doesn't exist
    (( $+functions[_ssht_cache_policy] )) || _ssht_cache_policy() {
      # Cache invalidates after 1 hour
      #
      # Reference:
      #   https://zsh.sourceforge.net/Doc/Release/Expansion.html#index-globbing_002c-qualifiers
      local -a oldp
      oldp=( "$1"(ms+3600) )
      (( $#oldp ))
    }

    # Unless user explicitly turned off caching, enable caching just for this context
    local existing_setting
    zstyle -s ":completion:${curcontext}:" use-cache existing_setting
    if [[ -z "${existing_setting}" ]]; then
      zstyle ":completion:${curcontext}:" use-cache on
    fi

    # Update cache policy only when there was no existing policy
    local existing_policy
    zstyle -s ":completion:${curcontext}:" cache-policy existing_policy
    if [[ -z "${existing_policy}" ]]; then
      zstyle ":completion:${curcontext}:" cache-policy _ssht_cache_policy
    fi

    local -a instances
    if _cache_invalid ssht_instances || ! _retrieve_cache ssht_instances; then
      local instances
      local stderr
      local -i exit_code
      () {
        ssh -I /usr/lib/libykcs11.so fra1-test -- --osh groupListServers --group sre 2>/dev/null | awk -F'=' '/hostname/{print $2}' | sort -u >${1} 2>${2}
        exit_code=${?}
        IFS=$'\n\t' instances=($(<${1}))
        stderr=$(<${2})
      } =(:) =(:)

      if (( $exit_code == 0 )); then
        # Bastion CLI successfully executed
        _store_cache ssht_instances instances
      else
        # Bastion CLI failed, abort autocompletion
        _message -r "\
    Failed autocomplete due to following reason:
    ${stderr}"
        return
      fi
    fi
    _describe 'command' instances
}
compdef _ssht ssht

# Completion for the alias sshp
_bfra2() {
    integer ret=1

    # Define function only when it doesn't exist
    (( $+functions[_bfra2_cache_policy] )) || _bfra2_cache_policy() {
      # Cache invalidates after 1 hour
      #
      # Reference:
      #   https://zsh.sourceforge.net/Doc/Release/Expansion.html#index-globbing_002c-qualifiers
      local -a oldp
      oldp=( "$1"(ms+3600) )
      (( $#oldp ))
    }

    # Unless user explicitly turned off caching, enable caching just for this context
    local existing_setting
    zstyle -s ":completion:${curcontext}:" use-cache existing_setting
    if [[ -z "${existing_setting}" ]]; then
      zstyle ":completion:${curcontext}:" use-cache on
    fi

    # Update cache policy only when there was no existing policy
    local existing_policy
    zstyle -s ":completion:${curcontext}:" cache-policy existing_policy
    if [[ -z "${existing_policy}" ]]; then
      zstyle ":completion:${curcontext}:" cache-policy _bfra2_cache_policy
    fi

    local -a instances
    if _cache_invalid bfra2_instances || ! _retrieve_cache bfra2_instances; then
      local instances
      local stderr
      local -i exit_code
      () {
        ssh -I /usr/lib/libykcs11.so fra2-production -- --osh groupListServers --group sre 2>/dev/null | awk -F'=' '/hostname/{print $2}' | sort -u >${1} 2>${2}
        exit_code=${?}
        IFS=$'\n\t' instances=($(<${1}))
        stderr=$(<${2})
      } =(:) =(:)

      if (( $exit_code == 0 )); then
        # Bastion CLI successfully executed
        _store_cache bfra2_instances instances
      else
        # Bastion CLI failed, abort autocompletion
        _message -r "\
    Failed autocomplete due to following reason:
    ${stderr}"
        return
      fi
    fi
    _describe 'command' instances
}

compdef _bfra2 bfra2



_bfra3() {
    integer ret=1
    local cache
    cache="/$HOME/.cache/bfra3-cache"
    if [ -e "$cache" ] && [ "$(($(date +%s) - $(/sbin/stat -c %Y "$cache")))" -lt "3600" ]; then
        compadd ${(uo)$(cat "$cache")}
    else
        ssh -I /usr/lib/libykcs11.so fra2-production -- --osh groupListServers --group sre 2>/dev/null | awk -F'=' '/hostname/{print $2}' | sort -u > $cache
        compadd ${(uo)$(cat "$cache")}
    fi
    _describe 'command' instances
    _alternative 'servers:servers:_bfra3_servers' && ret=0
}

compdef _bfra3 bfra3
