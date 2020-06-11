


test:: tests/client.log

generate:: src/kubernetes/api/generated

src/kubernetes/api/generated: bin/generator
	mkdir -p src/kubernetes/api
	bin/generator --output=src/kubernetes/api --include=io_k8s_
	touch src/kubernetes/api/generated

bin/generator: src/build/generator.nim $(wildcard src/kubernetes/*.nim)
	mkdir -p bin
	nim c -d:ssl src/build/generator.nim
	mv src/build/generator bin/generator


tests/client.log: src/kubernetes/api/generated tests/client.nim $(wildcard src/kubernetes/*.nim)
	nim c -r -d:ssl tests/client.nim > tests/client.log
	rm tests/client
