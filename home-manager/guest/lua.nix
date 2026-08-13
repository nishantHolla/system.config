## lua settings and packages for nishant
{config, pkgs, ...}:

{

    # Packages
    home.packages = with pkgs; [
        lua5_1                     # Powerful, fast, lightweight, embeddable scripting language
        lua51Packages.luarocks     # A package manager for Lua modules.
    ];
}
