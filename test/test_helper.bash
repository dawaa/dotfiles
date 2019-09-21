load '../libs/bats-assert/load'
load '../libs/bats-support/load'

setup() {
    if [ -z "$DOTFILES_TEST_DIR" ]; then
        DOTFILES_TEST_DIR="${BATS_TMPDIR}/dotfiles"
        DOTFILES_TEST_DIR="$(mktemp -d "${DOTFILES_TEST_DIR}.XXX")" 2> /dev/null || echo "$DOTFILES_TEST_DIR"
        export DOTFILES_TEST_DIR

        PATH="${BATS_TEST_DIRNAME}/../../bin:${PATH}"
    fi
}

teardown() {
    rm -rf "$DOTFILES_TEST_DIR"
}

_log() {
    echo "$@" | sed -e 's/^/# /' >&3 ;
}
