Dotfiles
========================

## Table of Contents
* [Programs](#programs)
* [Vim](#vim)
  * [Gotchas](#gotchas)
  * [Plugin manager](#plugin-manager)
    * [To install Vundle](#to-install-vundle)
    * [Install plugins](#install-plugins)
* [Karabiner Elements](#karabiner-elements)
* [Color schemes](#color-schemes)
  * [To install base16-shell](#to-install-base16-shell)
* [iTerm2 key-mappings](#iterm2-key-mappings)
  * [Switching between panes](#switching-between-panes)
* [Search using Ag](#search-using-ag)
  * [Find trailing whitespaces](#find-trailing-whitespaces)
  * [Find whitespaces of death](#find-whitespaces-of-death)
* [~~Hardlinking directories in OSX~~](#hardlinking-directories-in-osx)
  * [~~Post hardlink~~](#post-hardlink)


### Programs

These are useful programs that are part of my everyday workflow.

Install
- `brew install nvm`
- `brew install tmux`
- `brew install vim`
- `brew install git`
- `brew install fzf`
- `brew install ripgrep`
- [Vimac](https://vimacapp.com/) &mdash; adds Vimium-like hints to the macOS
- [Cursorcerer](http://doomlaser.com/cursorcerer-hide-your-cursor-at-will/) &mdash; helps hiding the cursor after X seconds to increase focus

### Vim

I use Vim for my work and like so many I've over the years tailored my `.vimrc` into my very own. Even though it's meant for myself primarily I write this to help my future-self to get my environment set up and ready so that I can start working asap..

#### Gotchas

Must run the following command below. Since I started using buffers I added a configuration setting that allows Vim to persist undo history between sessions. Where Vim will store that information is where we must create a directory before it can store it.

```
$ mkdir ~/.vim/undo
```

#### Plugin manager

So I've always used [Vundle](https://github.com/VundleVim/Vundle.vim) as my plugin manager and have no intention of changing. It works and does exactly what I need of it.


##### To install Vundle

> $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

##### Install plugins

After [Vundle](https://github.com/VundleVim/Vundle.vim) has finished installing we can now install the plugins defined under `.vim/config/plugins.vim`.

Launch `vim`and run `:PluginInstall`

or from the command line

`vim +PluginInstall +qall`

...and you'll have "mag

### Karabiner Elements

I use [Karabiner Elements](https://github.com/tekezo/Karabiner-Elements) to map
Option + h/j/k/l to arrow keys. This to avoid context switching even further
when having to hit those nasty-too-far-away keys and then find my way back to my
beloved h, j, k and l.

The config I use can be found under `.config/karabiner/karabiner.json`.

### Color schemes

I make use of the brilliant base16-shell for both the Shell itself but it also
covers the Vim part.

> https://github.com/chriskempson/base16-shell

##### To install base16-shell

```
https://github.com/chriskempson/base16-shell
```

And the following should already be added to the `.bashrc` file.

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
| ctrl-b + r     | cmd+r     | 0x02 0x52 | Re-runs last command in previous pane |
| ctrl-b + ;     | cmd+s     | 0x02 0x3B | Switch to last pane |


## Search using Ag
### Find trailing whitespaces
```
ag --no-multiline \\s+$

# Deal with all the findings
cfdo %s/\v\s+$//ge | update
```

### Find whitespaces of death

```
ag --no-multiline  

# Deal with all the findings
cfdo %s/ / /ge | update
```

## ~~Hardlinking directories in OSX~~

> **Note** that this doesn't work anymore since High Sierra... Thanks Apple

With the help of this git repo (`https://github.com/selkhateeb/hardlink`) we
can hardlink directories, making actual directories source-able to Vim.

### ~~Post hardlink~~

When we have hardlinked our directories we must also install Vundle to get
the set up to work..

