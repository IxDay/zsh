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
