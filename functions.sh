function tpane() {
	tmux split-window -d
	tmux split-window -d -h
}

function fpane() {
	tpane
	tmux split-window -d -h -t2
}

