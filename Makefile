

test: tests/test.log

generate: src/n8s/api/generated

src/n8s/api/api.json: src/build/api_download.nim
	nim c -r src/build/api_download.nim
	rm -f src/build/api_download


src/n8s/api/generated: bin/generator src/n8s/api/api.json
	mkdir -p src/n8s/api
	bin/generator --output=src/n8s/api --include=io_k8s_  --input=src/n8s/api/api.json
	touch src/n8s/api/generated

bin/generator: src/build/generator.nim
	mkdir -p bin
	nim c src/build/generator.nim
	mv src/build/generator bin/generator

tests/test.log: src/n8s/api/generated $(wildcard src/n8s/*.nim) $(wildcard tests/*.nim)
	nim c -r tests/test.nim
	touch tests/test.log
	rm tests/test

