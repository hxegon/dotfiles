function cdgg() {
    cd "$(git gtr go $1)"
}

function gtrb() {
    local branch=$(git branch --format='%(refname:short)' | fzf --prompt="select a branch to make a worktree from > ")
    [[ -z "$branch" ]] && return 1

    echo -n "enter short name for new worktree: "
    read name
    [[ -z "$name" ]] && return 1

    local current=$(git branch --show-current)
    if [[ "$branch" == "$current" ]]; then
        git gtr new "$branch" --force --folder "$name"
    else
        git gtr new "$name" --from "$branch"
    fi

    local wt_path=$(git worktree list --porcelain | awk '/^worktree /{path=$2} END{print path}')
    cd "$wt_path"
}

function ggcd() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        echo "ggcd: not in a git repository" >&2
        return 1
    fi

    local current_path
    current_path=$(git rev-parse --show-toplevel)

    local -a all_paths
    local main_path=""
    local first=1
    while IFS= read -r line; do
        if [[ "$line" == worktree\ * ]]; then
            local p="${line#worktree }"
            all_paths+=("$p")
            if (( first )); then
                main_path="$p"
                first=0
            fi
        fi
    done < <(git worktree list --porcelain)

    if (( ${#all_paths[@]} <= 1 )); then
        echo "ggcd: no linked worktrees found" >&2
        return 1
    fi

    local -A label_to_path
    local -a labels
    for p in "${all_paths[@]}"; do
        [[ "$p" == "$current_path" ]] && continue
        local label
        label="$(basename "$p")"
        [[ "$p" == "$main_path" ]] && label+=" (main)"
        label_to_path[$label]="$p"
        labels+=("$label")
    done

    if (( ${#labels[@]} == 0 )); then
        echo "ggcd: no other worktrees to switch to" >&2
        return 1
    fi

    local current_label
    current_label="$(basename "$current_path")"
    [[ "$current_path" == "$main_path" ]] && current_label+=" (main)"

    local selected
    selected=$(printf '%s\n' "${labels[@]}" | fzf --prompt="[$current_label] > ")

    [[ -z "$selected" ]] && return 0

    cd "${label_to_path[$selected]}"
}

function ggrm() {
    git gtr rm $(git gtr list --porcelain | cut -f2 | fzf)
}

function wttr() {
    curl http://wttr.in/$1
}

function fzydir() {
    rg --files-with-matches scoop | xargs -n 1 dirname | fzf
}

bindkey -s ^f "tms\n"
