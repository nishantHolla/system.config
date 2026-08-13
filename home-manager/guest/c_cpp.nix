## C and C++ settings and packages for guest
{config, pkgs, ...}:

{

    # Packages
    home.packages = with pkgs; [
        clang-tools                # Standalone command line tools for C++ development
        gcc                        # GNU Compiler Collection, version 14.2.1.20250322 (wrapper script)
        gdb                        # GNU Project debugger
        libgcc                     # GNU Compiler Collection, version 14.2.1.20250322
    ];
}
