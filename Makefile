VENV ?= ~/.venv
BRANCH ?=
APP_IMAGE ?=
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
	VARS="APP_IMAGE=$(APP_IMAGE) CI_COMMIT_SHORT_SHA=$(CI_COMMIT_SHORT_SHA) DOCKERUSER=$(USERNAME) DOCKERPASS=$(PASSWORD)"; \
	ansible-playbook -i $(BRANCH) --extra-vars $$VARS --private-key=/sshkey k8s_deploy.yml 
