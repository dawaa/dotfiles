#!/usr/bin/env bats

load ../test_helper

pwd() { echo "${DOTFILES_TEST_DIR}"; }

@test "copies .vim/ directory to repo" {
  export -f pwd
  mkdir -p "${DOTFILES_TEST_DIR}/.vim/"

  run update

  [ -d "$DOTFILES_TEST_DIR/.vim" ]
  [ -f "$DOTFILES_TEST_DIR/.vim/setup.vim" ]
}

@test "excludes ./vim/bundle" {
  export -f pwd
  mkdir -p "${DOTFILES_TEST_DIR}/.vim/"

  run update

  [ ! -d "$DOTFILES_TEST_DIR/.vim/bundle" ]
}

@test "excludes ./vim/undo" {
  export -f pwd
  mkdir -p "${DOTFILES_TEST_DIR}/.vim/"

  run update

  [ ! -d "$DOTFILES_TEST_DIR/.vim/undo" ]
}

@test "copies .vimrc to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.vimrc" ]
}

@test "copies .tmux.conf to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.tmux.conf" ]
}

@test "copies .bashrc to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.bashrc" ]
}

@test "copies .bash_profile to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.bash_profile" ]
}

@test "copies .vimrc_background to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.vimrc_background" ]
}

@test "copies .gitconfig to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.gitconfig" ]
}

@test "copies .gitignore to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.gitignore" ]
}

@test "copies .gitignore_global to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.gitignore_global" ]
}

@test "copies .ctags to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.ctags" ]
}

@test "copies karabiner config to repo" {
  export -f pwd

  run update

  [ -f "$DOTFILES_TEST_DIR/.config/karabiner/karabiner.json" ]
}
