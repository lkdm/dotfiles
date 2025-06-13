
function _zellij_pane_pwd() {
  if [[ -n $ZELLIJ ]]; then
    # local current_dir=$(pwd)
    # local home_dir=$HOME
    # # Resolve symlinks for robust comparison
    # current_dir=$(realpath -- "$current_dir" 2>/dev/null || echo "$current_dir")
    # home_dir=$(realpath -- "$home_dir" 2>/dev/null || echo "$home_dir")
    # # Remove trailing slashes
    # current_dir=${current_dir%/}
    # home_dir=${home_dir%/}
    # if [[ "$current_dir" == "$home_dir" ]]; then
    #   current_dir="~"
    # else
    #   # Ensure replacement works for subdirectories
    #   if [[ "$current_dir" == "$home_dir"/* ]]; then
    #     current_dir="~${current_dir#$home_dir}"
    #   fi
    # fi
    command nohup zellij action rename-pane "shell" >/dev/null 2>&1
  fi
}


chpwd_functions=(${chpwd_functions[@]} "_zellij_pane_pwd")
precmd_functions=(${precmd_functions[@]} "_zellij_pane_pwd")

# When running a foreground process, rename to its resolved command
function _zellij_pane_app(){
    if [[ -n $ZELLIJ ]]; then 
      local name=$(echo $3 | cut -d' ' -f1)
      command nohup zellij action rename-pane $name >/dev/null 2>&1
    fi
}
preexec_functions=(${preexec_functions[@]} "_zellij_pane_app")
