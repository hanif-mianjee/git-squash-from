squash_from_commit_prompt() {
  count=$1

  if [ -z "$count" ] || ! echo "$count" | grep -Eq '^[0-9]+$'; then
    echo "Please provide a valid numeric count."
    return 1
  fi

  i=0
  while IFS= read -r line && [ "$i" -lt "$count" ]; do
    i=$((i + 1))
    commits[i]="$line"
  done <<EOF
$(git log --oneline --decorate -n "$count")
EOF

  if [ "$i" -eq 0 ]; then
    echo "No commits found."
    return 1
  fi

  echo "Select a commit to squash everything into:"
  for j in $(seq 1 $i); do
    echo "$j) ${commits[j]}"
  done

  while true; do
    printf "Enter number [1-$i]: "
    read choice
    if echo "$choice" | grep -Eq "^[0-9]+$" && [ "$choice" -ge 1 ] && [ "$choice" -le "$i" ]; then
      base_hash=$(echo "${commits[choice]}" | awk '{print substr($1, 1, 7)}')
      commit_message=$(git log --oneline --reverse "$base_hash^..HEAD" | sed '1s/^[^ ]* //; 2,$s/^/* /')

      echo "Squashing commits from ${base_hash}^ to HEAD..."

# Create a temp script for GIT_SEQUENCE_EDITOR to squash all commits except the first
seq_script=$(mktemp)
cat > "$seq_script" <<'EOF'
#!/bin/bash
sed -i '' '2,$s/^pick /squash /' "$1"
EOF
chmod +x "$seq_script"

# Start rebase with interactive squashing
GIT_SEQUENCE_EDITOR="$seq_script" git rebase -i "${base_hash}^"
rm -f "$seq_script"

# If rebase paused at commit message, inject custom message
if [ $? -eq 0 ]; then
  editor_script=$(mktemp)
  cat > "$editor_script" <<EOF
#!/bin/bash
cat <<MSG > "\$1"
$commit_message
MSG
EOF
  chmod +x "$editor_script"

  # Amend the commit with custom message non-interactively
    GIT_EDITOR=true git commit --amend -m "$commit_message" >/dev/null 2>&1
    rm -f "$editor_script"
    if [ -d ".git/rebase-merge" ] || [ -d ".git/rebase-apply" ]; then
  git rebase --continue >/dev/null 2>&1
fi

    echo "✅ Squash complete!"
fi


      break
    else
      echo "Invalid selection. Try again."
    fi
  done
}
