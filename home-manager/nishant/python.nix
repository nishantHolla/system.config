## python settings and packages for nishant
{config, pkgs, ...}:

{

    # Packages
    home.packages = with pkgs; [
        pyright                    # Type checker for the Python language
        ruff                       # Extremely fast Python linter and code formatter

        (python313.withPackages (ps: with ps; [
            debugpy  # Implementation of the Debug Adapter Protocol for Python
            typer    # Library for building CLI applications
        ]))
    ];
}
