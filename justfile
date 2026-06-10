# default: list available recipes
_default:
    @just -f {{justfile()}} -l

# proxy any command to the homebrew justfile
brew +args:
    @just -f sources/macos/homebrew/justfile {{args}}
