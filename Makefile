.DEFAULT_GOAL := install
TARGET_BIN="${HOME}/.local/bin"


install:
	echo "Attempting to install to $(TARGET_BIN)"
	mkdir -p $(TARGET_BIN)
	cp -v ./ttt ~/.local/bin
	go install -v ./tttlog.go
	command -v ttt
	command -v tttlog
