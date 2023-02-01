Dotfiles
========================

## Table of Contents
* [Programs](#programs)
* [Vim](#vim)
  * [Gotchas](#gotchas)
  * [CoC extensions](#coc-extensions)
* [Karabiner Elements](#karabiner-elements)
* [Color schemes](#color-schemes)
  * [To install base16-shell](#to-install-base16-shell)
* [iTerm2 key-mappings](#iterm2-key-mappings)
  * [Switching between panes](#switching-between-panes)
* [Search using Ag](#search-using-ag)
  * [Find trailing whitespaces](#find-trailing-whitespaces)
  * [Find whitespaces of death](#find-whitespaces-of-death)


### Programs

These are useful programs that are part of my everyday workflow.

Install
- `brew install nvm`
- `brew install tmux`
- `brew install vim`
- `brew install git`
- `brew install fzf` &mdash; make sure key bindings are installed and sourced, `~/.fzf.bash`
- `brew install ripgrep`
- `brew install ctags` &mdash; for [`vim-gutentags`](https://github.com/ludovicchabant/vim-gutentags)
- [Vimac](https://vimacapp.com/) &mdash; adds Vimium-like hints to the macOS
- [Cursorcerer](http://doomlaser.com/cursorcerer-hide-your-cursor-at-will/) &mdash; helps hiding the cursor after X seconds to increase focus
- Magnet
- Wireguard

### Vim

I use Vim for my work and like so many I've over the years tailored my `.vimrc` into my very own. Even though it's meant for myself primarily I write this to help my future-self to get my environment set up and ready so that I can start working asap..

#### Gotchas

Must run the following command below. Since I started using buffers I added a configuration setting that allows Vim to persist undo history between sessions. Where Vim will store that information is where we must create a directory before it can store it.

```
$ mkdir ~/.vim/undo
```

#### CoC extensions

- `coc-highlight`
- `coc-tsserver`
- `coc-eslint`
- `coc-json`

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
