all: a search serve

SHELL:=/bin/bash
DIST:=docs

a:
	@echo "Using $$0"

clean:
	rm -r ${DIST}

build:
	antora --stacktrace antora-playbook.yml

search:
	DOCSEARCH_ENABLED=true DOCSEARCH_ENGINE=lunr NODE_PATH="$(npm -g root)" antora --generator antora-site-generator-lunr antora-playbook.yml

serve:
	http-server ${DIST} -o