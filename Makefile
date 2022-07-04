VENV ?= ~/.venv
BRANCH ?=
PYTHON ?= python3
PIP ?= pip3
SHELL = /bin/bash
ANSIBLE_PATH ?= ansible
USER ?= user
export PATH := $(CURDIR)/$(VENV)/bin:$(PATH)
export ANSIBLE_HOST_KEY_CHECKING=False

define source_venv
	source $(VENV)/bin/activate
endef

.PHONY: deploy
deploy:
	source $(VENV)/bin/activate;\
	cd $(ANSIBLE_PATH);\
	mkdir .temp && envsubst < varfile.yml > .temp/vars.yml; \
	ansible-playbook -i $(BRANCH) --private-key /sshkey k8s_deploy.yml

