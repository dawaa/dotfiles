#!/usr/bin/env bats

# Test suite for bin/restore and bin/update scripts
# CRITICAL: This test suite is COMPLETELY ISOLATED from your real dotfiles
# It creates temporary directories and NEVER touches your actual home or repo

setup() {
    # Create completely isolated temporary test environment
    export ORIGINAL_HOME="$HOME"
    export TEST_ROOT=$(mktemp -d)
    export TEST_REPO_DIR="$TEST_ROOT/test_repo"
    export TEST_HOME_DIR="$TEST_ROOT/test_home"

    # Create isolated test directories
    mkdir -p "$TEST_REPO_DIR"
    mkdir -p "$TEST_HOME_DIR"
    mkdir -p "$TEST_HOME_DIR/.config/karabiner"
    mkdir -p "$TEST_HOME_DIR/.vim/undo"
    mkdir -p "$TEST_HOME_DIR/.vim/bundle"

    # Create isolated copies of the scripts in test repo
    mkdir -p "$TEST_REPO_DIR/bin"
    cp "$BATS_TEST_DIRNAME/restore" "$TEST_REPO_DIR/bin/restore"
    cp "$BATS_TEST_DIRNAME/update" "$TEST_REPO_DIR/bin/update"
    chmod +x "$TEST_REPO_DIR/bin/restore"
    chmod +x "$TEST_REPO_DIR/bin/update"

    # Override HOME to test environment - CRITICAL SAFETY
    export HOME="$TEST_HOME_DIR"
}

teardown() {
    # Restore original HOME - CRITICAL SAFETY
    export HOME="$ORIGINAL_HOME"

    # Clean up test environment completely
    if [ -d "$TEST_ROOT" ]; then
        rm -rf "$TEST_ROOT"
    fi
}

# Helper: Create test files in isolated test repo
create_repo_files() {
    echo "test_tmux" > "$TEST_REPO_DIR/.tmux.conf"
    echo "test_vimrc" > "$TEST_REPO_DIR/.vimrc"
    echo "test_bashrc" > "$TEST_REPO_DIR/.bashrc"
    echo "test_profile" > "$TEST_REPO_DIR/.profile"
    echo "test_inputrc" > "$TEST_REPO_DIR/.inputrc"
    echo "test_npmrc" > "$TEST_REPO_DIR/.npmrc"
    echo "test_yabairc" > "$TEST_REPO_DIR/.yabairc"
    echo "test_skhdrc" > "$TEST_REPO_DIR/.skhdrc"
    echo "test_vimrc_bg" > "$TEST_REPO_DIR/.vimrc_background"
    echo "test_gitconfig" > "$TEST_REPO_DIR/.gitconfig"
    echo "test_gitignore" > "$TEST_REPO_DIR/.gitignore"
    echo "test_gitignore_global" > "$TEST_REPO_DIR/.gitignore_global"
    echo "test_rgignore" > "$TEST_REPO_DIR/.rgignore"

    mkdir -p "$TEST_REPO_DIR/.vim/config"
    echo "test_vim_config" > "$TEST_REPO_DIR/.vim/config/test.vim"
}

# Helper: Create test files in isolated test home
create_home_files() {
    echo "home_tmux" > "$TEST_HOME_DIR/.tmux.conf"
    echo "home_vimrc" > "$TEST_HOME_DIR/.vimrc"
    echo "home_bashrc" > "$TEST_HOME_DIR/.bashrc"
    echo "home_profile" > "$TEST_HOME_DIR/.profile"
    echo "home_inputrc" > "$TEST_HOME_DIR/.inputrc"
    echo "home_npmrc" > "$TEST_HOME_DIR/.npmrc"
    echo "home_yabairc" > "$TEST_HOME_DIR/.yabairc"
    echo "home_skhdrc" > "$TEST_HOME_DIR/.skhdrc"
    echo "home_vimrc_bg" > "$TEST_HOME_DIR/.vimrc_background"
    echo "home_gitconfig" > "$TEST_HOME_DIR/.gitconfig"
    echo "home_gitignore" > "$TEST_HOME_DIR/.gitignore"
    echo "home_gitignore_global" > "$TEST_HOME_DIR/.gitignore_global"
    echo "home_rgignore" > "$TEST_HOME_DIR/.rgignore"
    echo "home_ctags" > "$TEST_HOME_DIR/.ctags"

    mkdir -p "$TEST_HOME_DIR/.vim/config"
    mkdir -p "$TEST_HOME_DIR/.vim/bundle"
    mkdir -p "$TEST_HOME_DIR/.vim/undo"
    echo "home_vim_config" > "$TEST_HOME_DIR/.vim/config/test.vim"
    echo "bundle_file" > "$TEST_HOME_DIR/.vim/bundle/test.txt"
    echo "undo_file" > "$TEST_HOME_DIR/.vim/undo/test.txt"

    echo '{"test": "karabiner"}' > "$TEST_HOME_DIR/.config/karabiner/karabiner.json"
}

# ===== RESTORE SCRIPT TESTS =====
# HOME is already set to TEST_HOME_DIR in setup()
# Scripts are copied to TEST_REPO_DIR/bin in setup()

@test "restore: copies .tmux.conf from repo to home" {
    create_repo_files
    cd "$TEST_REPO_DIR"

    # Run isolated copy of restore script (HOME already points to TEST_HOME_DIR)
    ./bin/restore

    [ -f "$HOME/.tmux.conf" ]
    [ "$(cat $HOME/.tmux.conf)" = "test_tmux" ]
}

@test "restore: copies .vimrc from repo to home" {
    create_repo_files
    cd "$TEST_REPO_DIR"

    ./bin/restore

    [ -f "$HOME/.vimrc" ]
    [ "$(cat $HOME/.vimrc)" = "test_vimrc" ]
}

@test "restore: copies .bashrc from repo to home" {
    create_repo_files
    cd "$TEST_REPO_DIR"

    ./bin/restore

    [ -f "$HOME/.bashrc" ]
    [ "$(cat $HOME/.bashrc)" = "test_bashrc" ]
}

@test "restore: copies .vim directory from repo to home" {
    create_repo_files
    cd "$TEST_REPO_DIR"

    ./bin/restore

    [ -d "$HOME/.vim" ]
    [ -f "$HOME/.vim/config/test.vim" ]
}

@test "restore: does not copy empty files" {
    create_repo_files
    echo -n "" > "$TEST_REPO_DIR/.emptyfile"
    cd "$TEST_REPO_DIR"

    # Add empty file to the restore list temporarily
    sed -i.bak 's|".gitignore_global"|".gitignore_global"\n    ".emptyfile"|' ./bin/restore

    ./bin/restore

    [ ! -f "$HOME/.emptyfile" ]
}

@test "restore: copies all configured dotfiles" {
    create_repo_files
    cd "$TEST_REPO_DIR"

    ./bin/restore

    [ -f "$HOME/.profile" ]
    [ -f "$HOME/.inputrc" ]
    [ -f "$HOME/.npmrc" ]
    [ -f "$HOME/.yabairc" ]
    [ -f "$HOME/.skhdrc" ]
    [ -f "$HOME/.gitconfig" ]
    [ -f "$HOME/.gitignore" ]
}

# ===== UPDATE SCRIPT TESTS =====
# HOME is already set to TEST_HOME_DIR in setup()

@test "update: copies .tmux.conf from home to repo" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ -f "$TEST_REPO_DIR/.tmux.conf" ]
    [ "$(cat $TEST_REPO_DIR/.tmux.conf)" = "home_tmux" ]
}

@test "update: copies .vimrc from home to repo" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ -f "$TEST_REPO_DIR/.vimrc" ]
    [ "$(cat $TEST_REPO_DIR/.vimrc)" = "home_vimrc" ]
}

@test "update: copies .vim directory from home to repo" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ -d "$TEST_REPO_DIR/.vim" ]
    [ -f "$TEST_REPO_DIR/.vim/config/test.vim" ]
}

@test "update: excludes .vim/bundle directory" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ ! -d "$TEST_REPO_DIR/.vim/bundle" ]
}

@test "update: excludes .vim/undo directory" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ ! -d "$TEST_REPO_DIR/.vim/undo" ]
}

@test "update: does not copy empty files" {
    create_home_files
    echo -n "" > "$HOME/.emptyconfig"
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ ! -f "$TEST_REPO_DIR/.emptyconfig" ]
}

@test "update: copies karabiner config" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ -f "$TEST_REPO_DIR/.config/karabiner/karabiner.json" ]
}

@test "update: copies all configured dotfiles from home" {
    create_home_files
    cd "$TEST_REPO_DIR"

    ./bin/update

    [ -f "$TEST_REPO_DIR/.bashrc" ]
    [ -f "$TEST_REPO_DIR/.profile" ]
    [ -f "$TEST_REPO_DIR/.inputrc" ]
    [ -f "$TEST_REPO_DIR/.npmrc" ]
    [ -f "$TEST_REPO_DIR/.yabairc" ]
    [ -f "$TEST_REPO_DIR/.skhdrc" ]
}

# ===== INTEGRATION TESTS =====

@test "integration: restore then update produces identical files" {
    create_repo_files
    cd "$TEST_REPO_DIR"

    # First restore from test repo to test home
    ./bin/restore

    # Save content from test home
    original_tmux=$(cat "$HOME/.tmux.conf")

    # Clear test repo
    rm -f "$TEST_REPO_DIR"/.* 2>/dev/null || true
    rm -rf "$TEST_REPO_DIR/.vim" "$TEST_REPO_DIR/.config" 2>/dev/null || true

    # Update back from test home to test repo
    ./bin/update

    # Verify content matches
    [ -f "$TEST_REPO_DIR/.tmux.conf" ]
    [ "$(cat $TEST_REPO_DIR/.tmux.conf)" = "$original_tmux" ]
}
