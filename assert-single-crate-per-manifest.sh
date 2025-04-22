#!/usr/bin/env bash

metadata="$(cargo metadata --format-version=1)"
workspace_root="$(jq -r .workspace_root <<<"$metadata")"
multitarget_workspace_members="$(jq -r "$(cat <<EOQ
    .packages
  | map(select(.manifest_path | startswith("$workspace_root")))
  | map_values(.targets |= (. | map(select((any(.kind[]; . == "test") or any(.kind[]; . == "bench")) | not))))
  | map(select(.targets | length > 1))
  | map(. | del(.dependencies))
EOQ
)" <<<"$metadata")"

jq <<<"$multitarget_workspace_members"
