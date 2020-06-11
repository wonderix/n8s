


bin/test: test.nim $(wildcard src/kubernetes/*.nim) src/kubernetes/api/generated $(wildcard src/kubernetes/api/*.nim) 
	mkdir -p bin
	nim c -d:ssl test.nim
	mv test.out bin/test

generate:: src/kubernetes/api/generated

src/kubernetes/api/generated: bin/generator
	mkdir -p src/kubernetes/api
	bin/generator --output=src/kubernetes/api --include=io_k8s_
	touch src/kubernetes/api/generated

bin/generator: src/build/generator.nim $(wildcard src/kubernetes/*.nim)
	mkdir -p bin
	nim c -d:ssl src/build/generator.nim
	mv src/build/generator bin/generator