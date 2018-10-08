# Dotfiles

### Hardlinking directories in OSX
With the help of this git repo (`https://github.com/selkhateeb/hardlink`) we
can hardlink directories, making actual directories source-able to vim

### Post hardlink
When we have hardlinked our directories we must also install Vundle to get
the set up to work..

# Installation

## Plugin manager
So run the following:
> $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

After Vundle has been installed, we must install the plugins defined in
`.vim/config/plugins.vim`. Run either of the following to do so:

Launch `vim`and run `:PluginInstall`

or from the command line

`vim +PluginInstall +qall`

...and you'll have "magic"

## Color schemes
I make use of the brilliant base16-shell for both the Shell itself but it also
covers the vim part.

https://github.com/chriskempson/base16-shell

### Installation

```
https://github.com/chriskempson/base16-shell
```

And the following should already be implemented in the .basrc file.

```
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
```

## iTerm2 key-mappings

I use the following key mappings to make my life easier

### Switching between panes

| tmux cmd | mapping | hex code | description |
|----------------|---------|-------|------|
| ctrl-b + l (L) | cmd+l (L) | 0x02 0x6C | Moves to right pane |
| ctrl-b + k     | cmd+k     | 0x02 0x6B | Moves to pane above |
| ctrl-b + j     | cmd+j     | 0x02 0x6A | Moves to pane below |
| ctrl-b + h     | cmd+h     | 0x02 0x68 | Moves to left pane |
| ctrl-b + space | cmd+s     | 0x02 0x52 | Switch to last pane |
| ctrl-b + R     | cmd+r     | 0x02 0x3B | Re-runs last command in previous pane |

### Search using Ag

#### Find trailing whitespace

```
ag --no-multiline \\s+$

# Deal with all the findings
cfdo %s/\v\s+$//ge | update
```



#### Find whitespace of death

```
ag --no-multiline  

# Deal with all the findings
cfdo %s/ / /ge | update
```
