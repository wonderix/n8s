


bin/test: test.nim $(wildcard src/kubernetes/*.nim)
	mkdir -p bin
	nim c -d:ssl test.nim
	mv test.out bin/test

generate::
	nim c -r -d:ssl src/kubernetes/generator.nim