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

function hugo() {
	if [ "$1" = "new" ]; then
		command hugo new "post/$(date +'%Y-%m-%d')-$2.md"
	else
		command hugo $*
	fi
}
