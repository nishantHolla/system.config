## rust settings and packages for nishant
{config, pkgs, ...}:

{

    # Packages
    home.packages = with pkgs; [
        cargo                      # Downloads your Rust project's dependencies and builds your project
        rust-analyzer              # Language server for the Rust language
        rustc                      # Safe, concurrent, practical language (wrapper script)
    ]
}
