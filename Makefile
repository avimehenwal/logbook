all: a build serve

SHELL:=/bin/bash
DIST:=dist

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