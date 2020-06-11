


test:: tests/client.log

generate:: src/n8s/api/generated

src/n8s/api/generated: bin/generator
	mkdir -p src/n8s/api
	bin/generator --output=src/n8s/api --include=io_k8s_
	touch src/n8s/api/generated

bin/generator: src/build/generator.nim $(wildcard src/n8s/*.nim)
	mkdir -p bin
	nim c -d:ssl src/build/generator.nim
	mv src/build/generator bin/generator


tests/client.log: src/n8s/api/generated tests/client.nim $(wildcard src/n8s/*.nim)
	nim c -r -d:ssl tests/client.nim > tests/client.log
	rm tests/client
