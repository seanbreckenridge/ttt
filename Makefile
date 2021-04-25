.DEFAULT_GOAL := install
TARGET_BIN="${HOME}/.local/bin"


install:
	echo "Attempting to install 'ttt' to $(TARGET_BIN)"
	mkdir -p $(TARGET_BIN)
	cp -v ./ttt $(TARGET_BIN)
	go install -v ./tttlog.go
	command -v ttt
	command -v tttlog
