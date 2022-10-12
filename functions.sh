function tpane() {
	tmux split-window -d
	tmux split-window -d -h
}

function fpane() {
	tpane
	tmux split-window -d -h -t2
}

function delline() {
	sed -ie "${1}d" ${2}
}

function killp() {
	fuser -k ${1}/tcp
}

function tmpdir() {
	[ -t 1 ] && cd $(mktemp -d) && exit 0
	mktemp -d | tee /dev/stderr
}

function kns() {
	[ -z "$1" ] && kubectl get ns || kubectl config set-context --current --namespace "$1"
}
