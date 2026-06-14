## python settings and packages for nishant
{config, pkgs, ...}:

{

    # Packages
    home.packages = with pkgs; [
        pyright                    # Type checker for the Python language
        python313                  # High-level dynamically-typed programming language
        python313Packages.debugpy  # Implementation of the Debug Adapter Protocol for Python
        python313Packages.typer    # Library for building CLI applications
        ruff                       # Extremely fast Python linter and code formatter
    ];
}
