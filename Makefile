.DEFAULT_GOAL := install

install:

	# create temp dir
	[ -d /tmp/install-ttt ] && rm -rf /tmp/install-ttt
	mkdir -p /tmp/install-ttt
	cd /tmp/install-ttt; \
		wget "https://raw.githubusercontent.com/seanbreckenridge/ttt/master/tttlog.go"  "https://raw.githubusercontent.com/seanbreckenridge/ttt/master/ttt"; \
		chmod +x ./ttt; \
		sudo cp -v ./ttt /usr/local/bin; \
		go install -v ./tttlog.go
	# 'verifying theyre on your PATH. If this fails, the go bin directory/your PATH may not be configured properly'
	command -v ttt
	command -v tttlog
