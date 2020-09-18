all: a build serve

SHELL:=/bin/bash
DIST:=dist

a:
	@echo "Using $$0"

clean:
	rm -r ${DIST}

build:
	antora --stacktrace antora-playbook.yml

serve:
	http-server ${DIST} -o