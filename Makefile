all: a clean build serve

SHELL:=/bin/bash
DIST:=docs

a:
	@echo "Using $$0"

clean:
	rm -r ${DIST}

dev:
	antora --stacktrace --to-dir ${DIST} --title development \
	--require asciidoctor-chart antora-playbook.yml
	make serve

build:
	DOCSEARCH_ENABLED=true DOCSEARCH_ENGINE=lunr NODE_PATH="$(npm -g root)" \
	antora --generator antora-site-generator-lunr --to-dir ${DIST} \
	--stacktrace antora-playbook.yml
	touch ${DIST}/.nojekyll

serve:
	http-server ${DIST}