## zsh config for guest
{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        initContent = ''
unalias -m "*"
source $HOME/.config/zsh/zshrc
        '';
    };
}
