all: clean html pdf epub
web: clean html serve
art: pdf epub

SHELL:=/bin/bash
asciidoctor:=${HOME}/.rvm/gems/ruby-2.7.0/bin/asciidoctor
DIST:=docs
ART:=artifacts
CONTAINER = docker run --rm \
	--volume `pwd`:/documents/ \
	--user `id --user`:`id --group` \
	asciidoctor/docker-asciidoctor
CONTAINER-IT = docker run --rm -it \
	--volume `pwd`:/documents/ \
	--user `id --user`:`id --group` \
	asciidoctor/docker-asciidoctor
OPTIONS = --destination-dir ${ART} \
	--require asciidoctor-diagram \
	--require asciidoctor-mathematical \
	*.adoc
one = one ${later_variable}
two := two ${later_variable}
later_variable = later

clean:
	rm -r ${DIST} || true
	rm -r ${ART} || true
	rm -r ? || true

build: clean
	${asciidoctor} \
	--backend html5 \
	--doctype article \
	--destination-dir ${DIST} \
	--require asciidoctor-diagram \
	--require asciidoctor-mathematical \
	--timings *.adoc

# --require asciidoctor-chart is for node.js
# --base-dir chapters

html: clean
	${CONTAINER} asciidoctor \
		--backend html5 \
		--doctype article \
		--destination-dir ${DIST} \
		--require asciidoctor-diagram \
		--require asciidoctor-mathematical \
		--timings chapters/*.adoc

serve:
	http-server ${DIST}

docker:
	${CONTAINER-IT} bash

pdf:
	${CONTAINER} asciidoctor-pdf ${OPTIONS}

epub:
	${CONTAINER} asciidoctor-epub3 ${OPTIONS}
	rm -rfv ? || true

reveal: clean
	${CONTAINER} asciidoctor-revealjs ${OPTIONS}
	rm -rfv ? || true

test:
	echo $(one)
	echo $(two)

