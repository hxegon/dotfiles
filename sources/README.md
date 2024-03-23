# hxegon/dotfiles
A group of config files for tools, languages, editors, etc., meant to be linked with
the excellent gnu stow utility.

Ideally these would be written to be OS independent, or at least have detection
for the major OSs. As it is, don't expect any of these to work on anything other
then OS X, and maybe not even then ;)

## Usage
```bash
stow nvim
```
The structure of the nvim/ dir is as follows:
nvim
└── .config
    └── nvim
        ├── .gitignore
        ├── .gitmodules
        ├── .netrwhist
        ├── coc-settings.json
        ├── colors
        ├── init.vim
        └── plugged

when you use the stow command, it drops a symlinked version of that into $HOME,
without destroying the other contents of $HOME/.config.
