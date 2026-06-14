## lua settings and packages for nishant
{config, pkgs, ...}:

{

    # Packages
    home.packages = with pkgs; [
        lua5_4                     # Powerful, fast, lightweight, embeddable scripting language
        lua54Packages.luarocks     # A package manager for Lua modules.
    ];
}
