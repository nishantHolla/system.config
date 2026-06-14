## zsh config for nishant
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
