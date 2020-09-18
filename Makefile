all: a clean build serve

SHELL:=/bin/bash

a:
		@echo "Using $$0"

clean:
		rm -rfv dist

build:
		 antora antora-playbook.yml

serve:
		http-server dist