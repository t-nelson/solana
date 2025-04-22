#!/usr/bin/env bash

declare -A remote_crates
declare -a pinned_remote_crates

while IFS=$',\r' read name version; do
  if [ x"${version:0:1}" == x"=" ]; then
    pinned_remote_crates+=("$name")
    version="${version:1}"
  fi
  remote_crates[$name]="$version"
done < <(toml get Cargo.toml . | jq -r '
    .workspace.dependencies
  | to_entries
  | map(select(((
        .key | startswith("solana-")
      ) or (
        .key | startswith("spl-")
    )) and ((
        .value | type == "string"
      ) or (
        .value | has("path") | not
    ))
  )) | map(
    if .value | type == "object" then
      .key+","+.value.version
    else
      .key+","+.value
    end
  ) | .[]
')

rc=0
bin_paths=$(find . -type f -path '*/src/main.rs')

for bin_path in $bin_paths; do
  unset unpinned
  unset wrong_version

  declare -a unpinned
  declare -A wrong_version

  manifest_path="$(realpath "$(dirname "$bin_path")"/../Cargo.toml)"
  manifest_json="$(toml get "$manifest_path" .)"

  if ! `jq '.package.publish // true' <<<"$manifest_json"`; then
    echo "$manifest_path not published"
    continue
  fi

  while IFS=$',\r' read name version; do
    wkspc_version="${remote_crates[$name]}"
    if [ -n "${wkspc_version}" ]; then
      if [ x"${version:0:1}" == x"=" ]; then
        version="${version:1}"
      elif [ x"${version}" != x"workspace" ]; then
        unpinned+=("$name")
      fi
      if [ x"$version" != x"$wkspc_version" ]; then
        wrong_version["$name"]="$version,$wkspc_version"
      fi
    fi
  done < <(jq -r '
      .dependencies // []
    | to_entries 
    | map(select(((
        .key | startswith("solana-")
      ) or (
        .key | startswith("spl-")
      ))
    ))
    | map(
      .key+","+(
        if .value | type == "string" then
          .value
        elif .value | has("version") then
          .value.version
        elif .value | has("workspace") then
          "workspace"
        end
    ))
    | .[]
  ' <<<"$manifest_json")

  if [ ${#unpinned[@]} -ne 0 ]; then
    rc=1
    echo "These crates must be pinned in '$manifest_path':" 1>&2
    for crate in ${unpinned}; do
      echo "    $crate" 1>&2
    done
  fi

  if [ ${#wrong_version[@]} -ne 0 ]; then
    rc=1
    echo "These crates have the wrong version in '$manifest_path':" 1>&2
    for crate in ${!wrong_version[@]}; do
      IFS=$',\r' read version expected <<<"${wrong_version["$crate"]}"
      echo "    $crate: has '$version' but expected '=$expected'" 1>&2
    done
  fi
done

exit $rc
