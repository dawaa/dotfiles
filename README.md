# Dotfiles

### Hardlinking directories in OSX
With the help of this git repo (`https://github.com/selkhateeb/hardlink`) we
can hardlink directories, making actual directories source-able to vim

### Post hardlink
When we have hardlinked our directories we must also install Vundle to get
the set up to work..

So run the following:
> $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

After Vundle has been installed, we must install the plugins defined in
`.vim/config/plugins.vim`. Run either of the following to do so:

Launch `vim`and run `:PluginInstall`

or from the command line

`vim +PluginInstall +qall`

...and you'll have "magic"
