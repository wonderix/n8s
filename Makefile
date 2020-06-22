



generate: src/n8s/api/generated

src/n8s/api/generated: bin/generator
	mkdir -p src/n8s/api
	bin/generator --output=src/n8s/api --include=io_k8s_
	touch src/n8s/api/generated

bin/generator: src/build/generator.nim src/n8s/client.nim
	mkdir -p bin
	nim c src/build/generator.nim
	mv src/build/generator bin/generator

test: tests/test.log
tests/test.log: src/n8s/api/generated $(wildcard src/n8s/*.nim) $(wildcard tests/*.nim)
	nim c -r tests/test.nim
	touch tests/test.log
	rm tests/test

