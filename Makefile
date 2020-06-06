


bin/test: test.nim $(wildcard src/kubernetes/*.nim)
	mkdir -p bin
	nim c -d:ssl test.nim
	mv test bin/test	