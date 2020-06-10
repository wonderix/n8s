


bin/test: test.nim $(wildcard src/kubernetes/*.nim) $(wildcard test/*.nim)
	mkdir -p bin
	nim c -d:ssl test.nim
	mv test.out bin/test

generate:: bin/generator
	mkdir -p src/kubernetes/api
	bin/generator --output=src/kubernetes/api --include=io_k8s_

bin/generator: src/build/generator.nim $(wildcard src/kubernetes/*.nim)
	mkdir -p bin
	nim c -d:ssl src/build/generator.nim
	mv src/build/generator bin/generator