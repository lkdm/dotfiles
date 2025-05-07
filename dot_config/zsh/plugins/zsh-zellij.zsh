function _zellij_pane_app(){
    if [[ -n $ZELLIJ ]]; then 
      local name=$(echo $3 | cut -d' ' -f1)
      command nohup zellij action rename-pane $name >/dev/null 2>&1
    fi
}

# TODO remember to credit algusdark for this inspiration
# https://www.reddit.com/r/zellij/comments/10skez0/does_zellij_support_changing_tabs_name_according/
function _zellij_pane_pwd(){
    if [[ -n $ZELLIJ ]]; then 
      local current_dir=$PWD 
      if [[ $current_dir == $HOME ]]; then 
        current_dir="~" 
      else 
        current_dir=${current_dir##*/} 
      fi 
        command nohup zellij action rename-pane $current_dir >/dev/null 2>&1 
    fi
}

chpwd_functions=(${chpwd_functions[@]} "_zellij_pane_pwd")
preexec_functions=(${preexec_functions[@]} "_zellij_pane_app")
precmd_functions=(${precmd_functions[@]} "_zellij_pane_ls_pwd")


