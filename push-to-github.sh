#!/usr/bin/env bash
set -euo pipefail

# Push claude-research to mustrockux GitHub (NOT chronosphere)
cd "$(dirname "$0")"

if [ ! -d .git ]; then
  git init -b main
fi

echo '.DS_Store' > .gitignore

# Remove any chronosphere remotes
for remote in $(git remote 2>/dev/null || true); do
  url=$(git remote get-url "$remote" 2>/dev/null || true)
  if echo "$url" | grep -qi chronosphere; then
    git remote remove "$remote"
    echo "Removed chronosphere remote: $remote"
  fi
done

# Ensure origin points to personal account
if git remote get-url origin >/dev/null 2>&1; then
  url=$(git remote get-url origin)
  if echo "$url" | grep -qi chronosphere; then
    git remote remove origin
  fi
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin git@github.com:mustrockux/claude-research.git
fi

git add -A
if ! git rev-parse HEAD >/dev/null 2>&1; then
  git commit -m "Initial commit: synthetic research docs and personas"
fi

if ! gh repo view mustrockux/claude-research >/dev/null 2>&1; then
  gh repo create mustrockux/claude-research --public --description "Synthetic research docs and personas"
fi

git push -u origin main

echo ""
echo "Done! Repo: https://github.com/mustrockux/claude-research"
git remote -v
