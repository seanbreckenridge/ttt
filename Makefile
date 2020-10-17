.DEFAULT_GOAL := install
TEMP_DIR="/tmp/install_ttt"

install:

	# create temp dir
	rm -rf $(TEMP_DIR)
	mkdir -p $(TEMP_DIR)
	cd $(TEMP_DIR); \
		wget "https://raw.githubusercontent.com/seanbreckenridge/ttt/master/tttlog.go"  "https://raw.githubusercontent.com/seanbreckenridge/ttt/master/ttt"; \
		chmod +x ./ttt; \
		sudo cp -v ./ttt /usr/local/bin; \
		go install -v ./tttlog.go
	# 'verifying theyre on your PATH. If this fails, the go bin directory/your PATH may not be configured properly'
	command -v ttt
	command -v tttlog
