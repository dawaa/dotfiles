#!/bin/bash
# Safety check to ensure tests won't touch real files
# Run this before running the test suite

set -euo pipefail

echo "🔒 Running safety checks for test suite..."

# Check that test.bats uses isolated directories
if grep -q 'ORIGINAL_HOME' bin/test.bats && \
   grep -q 'TEST_ROOT' bin/test.bats && \
   grep -q 'TEST_REPO_DIR' bin/test.bats && \
   grep -q 'TEST_HOME_DIR' bin/test.bats; then
    echo "✓ Test suite uses isolated directories"
else
    echo "✗ WARNING: Test suite may not be properly isolated!"
    exit 1
fi

# Check that setup() overrides HOME
if grep -q 'export HOME="$TEST_HOME_DIR"' bin/test.bats; then
    echo "✓ Test suite overrides HOME to test directory"
else
    echo "✗ WARNING: HOME may not be overridden in tests!"
    exit 1
fi

# Check that teardown() restores HOME
if grep -q 'export HOME="$ORIGINAL_HOME"' bin/test.bats; then
    echo "✓ Test suite restores original HOME in teardown"
else
    echo "✗ WARNING: Original HOME may not be restored!"
    exit 1
fi

# Check that teardown() cleans up
if grep -q 'rm -rf "$TEST_ROOT"' bin/test.bats; then
    echo "✓ Test suite cleans up temporary directories"
else
    echo "✗ WARNING: Temporary directories may not be cleaned up!"
    exit 1
fi

# Verify scripts exist
if [ ! -f "bin/restore" ] || [ ! -f "bin/update" ]; then
    echo "✗ ERROR: Required scripts not found!"
    exit 1
fi
echo "✓ All required scripts exist"

# Check real dotfiles aren't test data
if grep -q "^test_" ~/.vimrc 2>/dev/null || \
   grep -q "^test_" ~/.profile 2>/dev/null || \
   grep -q "^test_" ~/.bashrc 2>/dev/null; then
    echo "✗ WARNING: Your real dotfiles contain test data!"
    echo "  Run './bin/restore' to restore from repo"
    exit 1
fi
echo "✓ Real dotfiles don't contain test data"

echo ""
echo "✅ All safety checks passed!"
echo "It's safe to run: bats bin/test.bats"
